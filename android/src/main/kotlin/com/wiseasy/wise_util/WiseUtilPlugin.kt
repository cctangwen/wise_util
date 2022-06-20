package com.wiseasy.wise_util

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.util.Log
import androidx.annotation.NonNull
import com.aliyun.sls.android.producer.LogProducerCallback
import com.aliyun.sls.android.producer.LogProducerClient
import com.aliyun.sls.android.producer.LogProducerConfig
import com.aliyun.sls.android.producer.LogProducerException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File


/** WiseUtilPlugin */
class WiseUtilPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var logProducerClient: LogProducerClient? = null
    private var context: Context? = null
    var logProducerConfig: LogProducerConfig? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wise_util")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "init" -> {
                val params = call.arguments as List<String>
                initAliLog(
                    params[0],
                    params[1],
                    params[2],
                    params[3],
                    params[4],
                    params[5],
                    params[6]
                )
                result.success("")
            }
            "addLog" -> {
                val params = call.arguments as Map<String, String>
                val log = com.aliyun.sls.android.producer.Log()
                val entrySet: Set<Map.Entry<String, String>> = params.entries
                for ((key, value) in entrySet) {
                    log.putContent(key, value)
                }
                logProducerClient?.addLog(log)
                result.success("")
            }
            "addTag" -> {
                val params = call.arguments as Map<String, String>
                val entrySet: Set<Map.Entry<String, String>> = params.entries
                for ((key, value) in entrySet) {
                    logProducerConfig?.addTag(key, value)
                }
            }
            "isGooglePlayInstalled" -> {
                result.success(isGooglePlayInstalled(context!!))
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    //是否安装了谷歌市场
    private fun isGooglePlayInstalled(context: Context): Boolean {
        val isHuawei = checkAppInstalled(context, "com.huawei.camera");
        if (isHuawei) return false
        return try {
            val packageInfo = context.packageManager.getPackageInfo("com.android.vending", 0)
            packageInfo.applicationInfo.enabled
        } catch (exc: PackageManager.NameNotFoundException) {
            false
        }
    }

    //按包名检查应用是否安装
    private fun checkAppInstalled(context: Context, pkgName: String): Boolean {
        val packageInfo: PackageInfo?
        try {
            packageInfo = context.packageManager.getPackageInfo(
                pkgName,
                PackageManager.GET_ACTIVITIES or PackageManager.GET_SERVICES
            )
            if (packageInfo != null) {
                return true
            }
            val packageManager = context.packageManager
            val info = packageManager.getInstalledPackages(0)
            if (info.isEmpty()) return false
            for (i in info.indices) {
                val name = info[i].packageName
                if (pkgName == name) {
                    return true
                }
            }
        } catch (e: Exception) {
        }
        return false
    }

    private fun initAliLog(
        endPoint: String,
        project: String,
        logStore: String,
        accessKeyId: String,
        accessKeySecret: String,
        accessKeyToken: String,
        appAlisa: String,
    ) {
        try {
            logProducerConfig =
                LogProducerConfig(
                    context,
                    endPoint,
                    project,
                    logStore,
                    accessKeyId,
                    accessKeySecret,
                    accessKeyToken
                )
            // 设置主题
            logProducerConfig?.setTopic(appAlisa)
            // 每个缓存的日志包的大小上限，取值为1~5242880，单位为字节。默认为1024 * 1024
            logProducerConfig?.setPacketLogBytes(1024 * 1024)
            // 每个缓存的日志包中包含日志数量的最大值，取值为1~4096，默认为1024
            logProducerConfig?.setPacketLogCount(1024)
            // 被缓存日志的发送超时时间，如果缓存超时，则会被立即发送，单位为毫秒，默认为3000
            logProducerConfig?.setPacketTimeout(30000)
            // 单个Producer Client实例可以使用的内存的上限，超出缓存时add_log接口会立即返回失败
            // 默认为64 * 1024 * 1024
            logProducerConfig?.setMaxBufferLimit(64 * 1024 * 1024)
            // 发送线程数，默认为1
            logProducerConfig?.setSendThreadCount(1)

            //网络连接超时时间，整数，单位秒，默认为10
            logProducerConfig?.setConnectTimeoutSec(10)
            //日志发送超时时间，整数，单位秒，默认为15
            logProducerConfig?.setSendTimeoutSec(10)
            //flusher线程销毁最大等待时间，整数，单位秒，默认为1
            logProducerConfig?.setDestroyFlusherWaitSec(2)
            //sender线程池销毁最大等待时间，整数，单位秒，默认为1
            logProducerConfig?.setDestroySenderWaitSec(2)
            //数据上传时的压缩类型，默认为LZ4压缩，0 不压缩，1 LZ4压缩，默认为1
            logProducerConfig?.setCompressType(1)
            //设备时间与标准时间之差，值为标准时间-设备时间，一般此种情况用户客户端设备时间不同步的场景
            //整数，单位秒，默认为0；比如当前设备时间为1607064208, 标准时间为1607064308，则值设置为 1607064308 - 1607064208 = 10
            logProducerConfig?.setNtpTimeOffset(3)
            //日志时间与本机时间之差，超过该大小后会根据 `drop_delay_log` 选项进行处理。
            //一般此种情况只会在设置persistent的情况下出现，即设备下线后，超过几天/数月启动，发送退出前未发出的日志
            //整数，单位秒，默认为7*24*3600，即7天
            logProducerConfig?.setMaxLogDelayTime(7 * 24 * 3600)
            //对于超过 `max_log_delay_time` 日志的处理策略
            //0 不丢弃，把日志时间修改为当前时间; 1 丢弃，默认为 1 （丢弃）
            logProducerConfig?.setDropDelayLog(0)
            //是否丢弃鉴权失败的日志，0 不丢弃，1丢弃
            //默认为 0，即不丢弃
            logProducerConfig?.setDropUnauthorizedLog(0)
            // 是否使用主线程回调
            // false: 使用主线程回调。回调会在主线程上执行，且每个 client 都有自己单独的回调。
            // true: 使用 sender 线程回调。回调会在 sender 现呈上执行，每次执行回调时都会 attach 一个新的 java 线程，所有 client 共用一个回调。
            // 注意：默认使用 sender 线程回调。
            /**
             * 以下为开启断点续传的配置, 按照如下配置开启断点续传功能后, 日志会先缓存到本地
             */
            // 1 开启断点续传功能， 0 关闭
            // 每次发送前会把日志保存到本地的binlog文件，只有发送成功才会删除，保证日志上传At Least Once
            logProducerConfig?.setPersistent(1)
            // 持久化的文件名，需要保证文件所在的文件夹已创建。
            // !!!!!!!!!!!!!!!!!!!注意!!!!!!!!!!!!!!!!!!!
            // 配置多个客户端时，不应设置相同文件
            logProducerConfig?.setPersistentFilePath(
                context!!.filesDir.absolutePath + java.lang.String.format(
                    "%slog_data.dat",
                    File.separator
                )
            )
            // 是否每次AddLog强制刷新，高可靠性场景建议打开
            logProducerConfig?.setPersistentForceFlush(0)
            // 持久化文件滚动个数，建议设置成10。
            logProducerConfig?.setPersistentMaxFileCount(10)
            // 每个持久化文件的大小，建议设置成1-10M
            logProducerConfig?.setPersistentMaxFileSize(1024 * 1024)
            // 本地最多缓存的日志数，不建议超过1M，通常设置为65536即可
            logProducerConfig?.setPersistentMaxLogCount(65536)
            /**
             * 以下为通过 LogProducerConfig 构造一个 LogProducerClient 实例
             */
            // callback为可选配置, 如果不需要关注日志的发送成功或失败状态, 可以不注册 callback
            val callback =
                LogProducerCallback { resultCode: Int, reqId: String?, errorMessage: String?, logBytes: Int, compressedBytes: Int ->
                    // resultCode: 状态码, 详见 LogProducerResult
                    // reqId: 请求Id, 已经废弃
                    // errorMessage: 失败信息
                    // logBytes: 日志原始字节数
                    // compressedBytes: 日志压缩字节数
                    Log.e(
                        "WiseLog",
                        String.format(
                            "resultCode: %d, reqId: %s, errorMessage: %s, logBytes: %d, compressedBytes: %d",
                            resultCode,
                            reqId,
                            errorMessage,
                            logBytes,
                            compressedBytes
                        )
                    )
                }
            if (null != logProducerClient) {
                logProducerClient!!.destroyLogProducer();
            }
            // 需要关注日志的发送成功或失败状态时, 第二个参数需要传入一个 callbak
            logProducerClient = LogProducerClient(logProducerConfig, callback)
        } catch (e: LogProducerException) {
            e.printStackTrace()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

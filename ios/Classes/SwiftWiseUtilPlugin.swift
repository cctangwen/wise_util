import Flutter
import UIKit
import AliyunLogProducer

class AliyunLog {
    private var mLogConfig: LogProducerConfig;
    private lazy var mLogClient: LogProducerClient = LogProducerClient();

    init(endpoint:String, project:String, logstore:String, accessKeyID:String, accessKeySecret:String,securityToken:String,appAlisa:String) {
        mLogConfig = LogProducerConfig(endpoint:endpoint, project:project, logstore:logstore, accessKeyID:accessKeyID, accessKeySecret:accessKeySecret,securityToken:securityToken)!
        // 设置默认使用https
        mLogConfig.setUsingHttp(1)
        // 设置持久化日志
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = file! + "/log.dat"
        mLogConfig.setPersistentFilePath(path)
        mLogConfig.setPacketTimeout(1800000)
        setTopic(topic: appAlisa)
        mLogClient.destroyLogProducer()
        mLogClient = LogProducerClient(logProducerConfig: mLogConfig)
    }

    func setTopic(topic: String){
       return mLogConfig.setTopic(topic)
    }

    func addTag(content: [String: Any]){
        for(key, value) in content{
            mLogConfig.addTag(key, value: String(describing: value))
        }
    }

    func addLog(content: [String: String]) -> Bool {
        let log = Log()
        log.setTime(useconds_t(Date().timeIntervalSince1970))
        for(key, value) in content{
            log.putContent(key, value: value)
        }
        return mLogClient.add(log, flush:0) == LogProducerResult.OK
    }
}

public class SwiftWiseUtilPlugin: NSObject, FlutterPlugin {
   var logClient: AliyunLog?;

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "wise_util", binaryMessenger: registrar.messenger())
    let instance = SwiftWiseUtilPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "init"){
            let params = call.arguments as! [String];
            logClient = AliyunLog(endpoint: params[0], project: params[1], logstore: params[2], accessKeyID: params[3], accessKeySecret: params[4],securityToken:params[5],appAlisa: params[6])
            result(true)
        }
        guard let client = logClient else {
            result(false)
            return
        }

        if (call.method == "setTopic") {
            client.setTopic(topic: call.arguments as! String)
            result(nil)
        } else if (call.method == "addTag") {
            client.addTag(content: call.arguments as! [String: String])
            result(nil)
        } else if (call.method == "addLog") {
            result(client.addLog(content: call.arguments as! [String: String]))
        } else {
            result(nil)
        }
    }
}

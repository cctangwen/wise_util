#import "WiseUtilPlugin.h"
#if __has_include(<wise_util/wise_util-Swift.h>)
#import <wise_util/wise_util-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wise_util-Swift.h"
#endif

@implementation WiseUtilPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWiseUtilPlugin registerWithRegistrar:registrar];
}
@end

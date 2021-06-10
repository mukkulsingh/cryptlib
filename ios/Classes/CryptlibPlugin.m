#import "CryptlibPlugin.h"

@implementation CryptlibPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"cryptlib"
            binaryMessenger:[registrar messenger]];
  CryptlibPlugin* instance = [[CryptlibPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if([@"getEncryptedString"]){
      NSDictionary arguments = call.arguments;
      String key = arguments["key"];
      String text = arguments["text"];
      CryptLib cryptlib = CryptLib();
      result(cryptlib.)
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end

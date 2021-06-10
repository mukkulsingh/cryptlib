#import "CryptlibPlugin.h"
#import "CryptLib.h"
@implementation CryptlibPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"cryptlib"
            binaryMessenger:[registrar messenger]];
  CryptlibPlugin* instance = [[CryptlibPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
 if ([@"getEncryptedString" isEqualToString:call.method]) {
    NSDictionary *argument = call.arguments;
    NSString *key = argument[@"key"];
    NSString *text = argument[@"text"];
    CryptLib *cryptLib = [[CryptLib alloc]init];
    result([cryptLib encryptPlainTextRandomIVWithPlainText:text key: key]);

  }else if ([@"getDecryptedString" isEqualToString:call.method]) {
       NSDictionary *argument = call.arguments;
       NSString *key = argument[@"key"];
       NSString *text = argument[@"encryptedText"];
       CryptLib *cryptLib = [[CryptLib alloc]init];
       result([cryptLib decryptCipherTextRandomIVWithCipherText:text key: key]);
   }else {
    result(FlutterMethodNotImplemented);
  }
}
@end

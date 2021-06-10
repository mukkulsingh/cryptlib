package com.fitphilia.cryptlib;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** CryptlibPlugin */
public class CryptlibPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "cryptlib");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if(call.method.equals("getEncryptedString")){
      String k = call.argument("key");
      String text = call.argument("text");
      try{
        CryptLib crypt = new CryptLib();
        String output = "";
        output = crypt.encryptPlainTextWithRandomIV(text, k);
        result.success(output);
      }catch(Exception e){
        e.printStackTrace();
      }
    }else if(call.method.equals("getDecryptedString")){
      String k = call.argument("key");
      String text = call.argument("encryptedText");
      try{
        CryptLib crypt = new CryptLib();
        String output = "";
        output = crypt.decryptCipherTextWithRandomIV(text, k);
        result.success(output);
      }catch(Exception e){
        e.printStackTrace();
      }
    }else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}

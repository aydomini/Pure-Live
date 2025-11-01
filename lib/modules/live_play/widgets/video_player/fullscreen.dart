import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:auto_orientation_v2/auto_orientation_v2.dart';

//横屏
Future<void> landScape() async {
  dynamic document;
  try {
    if (kIsWeb) {
      await document.documentElement?.requestFullscreen();
    } else if (Platform.isAndroid || Platform.isIOS) {
      await AutoOrientation.landscapeAutoMode(forceSensor: true);
    } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      await const MethodChannel('com.alexmercerind/media_kit_video').invokeMethod('Utils.EnterNativeFullscreen');
    }
  } catch (exception, stacktrace) {
    debugPrint(exception.toString());
    debugPrint(stacktrace.toString());
  }
}

//竖屏
Future<void> verticalScreen() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

Future<void> doEnterFullScreen() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  } else {
    await const MethodChannel('com.alexmercerind/media_kit_video').invokeMethod('Utils.EnterNativeFullscreen');
  }
}

//退出全屏显示
Future<void> doExitFullScreen() async {
  dynamic document;
  late SystemUiMode mode = SystemUiMode.edgeToEdge;
  try {
    if (kIsWeb) {
      document.exitFullscreen();
    } else if (Platform.isAndroid || Platform.isIOS) {
      if (Platform.isAndroid && (await DeviceInfoPlugin().androidInfo).version.sdkInt < 29) {
        mode = SystemUiMode.manual;
      }
      // 🔧 优化：只恢复系统UI，不改变方向设置（由toggleFullScreen统一管理）
      await SystemChrome.setEnabledSystemUIMode(mode, overlays: SystemUiOverlay.values);
      // await SystemChrome.setPreferredOrientations([]);  // ❌ 已移除，避免冲突
    } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      await const MethodChannel('com.alexmercerind/media_kit_video').invokeMethod('Utils.ExitNativeFullscreen');
    }
  } catch (exception, stacktrace) {
    debugPrint(exception.toString());
    debugPrint(stacktrace.toString());
  }
}

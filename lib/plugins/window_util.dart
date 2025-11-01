import 'package:flutter/material.dart';
import 'package:pure_live/common/utils/index.dart';
import 'package:window_manager/window_manager.dart';

class WindowUtil {
  static String title = '纯粹直播';
  static Future<void> init({required double width, required double height}) async {
    double? windowsWidth = PrefUtil.getDouble('windowsWidth') ?? width;
    double? windowsHeight = PrefUtil.getDouble('windowsHeight') ?? height;

    // 检查是否有保存的窗口位置（首次打开时没有）
    double? savedXPosition = PrefUtil.getDouble('windowsXPosition');
    double? savedYPosition = PrefUtil.getDouble('windowsYPosition');
    bool hasStoredPosition = savedXPosition != null && savedYPosition != null;

    WindowOptions windowOptions = WindowOptions(
      size: Size(windowsWidth, windowsHeight),
      center: !hasStoredPosition, // 首次打开居中，之后恢复保存的位置
      minimumSize: Size(375, 667), // iPhone SE 尺寸（支持小窗口）
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      // 如果有保存的位置，恢复到该位置
      if (hasStoredPosition) {
        await windowManager.setPosition(Offset(savedXPosition, savedYPosition));
      }
      await windowManager.show();
      await windowManager.focus();
    });
  }

  static Future<void> setTitle() async {
    await windowManager.setTitle(title);
  }

  static Future<void> setWindowsPort() async {
    double? windowsXPosition = PrefUtil.getDouble('windowsXPosition') ?? 0.0;
    double? windowsYPosition = PrefUtil.getDouble('windowsYPosition') ?? 0.0;
    double? windowsWidth = PrefUtil.getDouble('windowsWidth') ?? 900;
    double? windowsHeight = PrefUtil.getDouble('windowsHeight') ?? 535;
    windowsWidth = windowsWidth > 375 ? windowsWidth : 375;   // 最小宽度：iPhone SE
    windowsHeight = windowsHeight > 667 ? windowsHeight : 667; // 最小高度：iPhone SE
    await windowManager.setBounds(Rect.fromLTWH(windowsXPosition, windowsYPosition, windowsWidth, windowsHeight));
  }

  static void setPosition() async {
    Offset offset = await windowManager.getPosition();
    Size size = await windowManager.getSize();
    bool isFocused = await windowManager.isFocused();
    if (isFocused) {
      await PrefUtil.setDouble('windowsXPosition', offset.dx);
      await PrefUtil.setDouble('windowsYPosition', offset.dy);
      await PrefUtil.setDouble('windowsWidth', size.width);
      await PrefUtil.setDouble('windowsHeight', size.height);
    }
  }
}

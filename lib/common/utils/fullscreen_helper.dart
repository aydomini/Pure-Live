import 'dart:io';
import 'package:get/get.dart';
import '../services/settings_service.dart';

/// 全屏状态辅助工具类
///
/// 用于智能判断播放器初始化时是否应该进入全屏
class FullscreenHelper {
  FullscreenHelper._();

  /// 判断初始化时是否应该进入全屏
  ///
  /// 优先级：
  /// 1. enableFullScreenDefault（强制全屏）- 最高优先级
  /// 2. lastExitWasFullscreen（记住上次状态）- macOS/Windows 专用
  /// 3. enableAutoRotationFullscreen + 当前方向 - iOS/Android 专用
  /// 4. 默认：窗口模式
  ///
  /// 参数：
  /// - [isLandscape]: 当前是否为横屏
  /// - [settings]: 设置服务实例（可选，默认从 Get.find 获取）
  ///
  /// 返回值：
  /// - true: 应该进入全屏
  /// - false: 保持窗口模式
  static bool shouldEnterFullscreenOnInit({
    required bool isLandscape,
    SettingsService? settings,
  }) {
    final settingsInstance = settings ?? Get.find<SettingsService>();

    // ==================== 优先级1：强制全屏 ====================
    // 用户设置了"默认全屏"，无论方向如何都进入全屏
    if (settingsInstance.enableFullScreenDefault.value) {
      return true;
    }

    // ==================== 优先级2：桌面端记忆上次状态 ====================
    if (Platform.isMacOS || Platform.isWindows) {
      final shouldFullscreen = settingsInstance.lastExitWasFullscreen.value;
      return shouldFullscreen;
    }

    // ==================== 优先级3：移动端自动旋转全屏 ====================
    if (Platform.isIOS || Platform.isAndroid) {
      // 用户启用了自动旋转全屏
      if (settingsInstance.enableAutoRotationFullscreen.value) {
        if (isLandscape) {
          return true;
        } else {
          return false;
        }
      }
    }

    // ==================== 默认：窗口模式 ====================
    return false;
  }

  /// 获取初始化全屏的详细信息（用于调试）
  ///
  /// 返回值示例：
  /// ```
  /// {
  ///   'shouldEnterFullscreen': true,
  ///   'reason': '当前横屏 + 自动旋转全屏开启',
  ///   'enableFullScreenDefault': false,
  ///   'enableAutoRotationFullscreen': true,
  ///   'isLandscape': true,
  ///   'platform': 'iOS'
  /// }
  /// ```
  static Map<String, dynamic> getFullscreenDecisionInfo({
    required bool isLandscape,
    SettingsService? settings,
  }) {
    final settingsInstance = settings ?? Get.find<SettingsService>();
    final shouldFullscreen = shouldEnterFullscreenOnInit(
      isLandscape: isLandscape,
      settings: settingsInstance,
    );

    String reason;
    if (settingsInstance.enableFullScreenDefault.value) {
      reason = '用户设置强制全屏';
    } else if (Platform.isMacOS || Platform.isWindows) {
      reason = '桌面端记住上次退出状态 = ${settingsInstance.lastExitWasFullscreen.value}';
    } else if (settingsInstance.enableAutoRotationFullscreen.value && isLandscape) {
      reason = '当前横屏 + 自动旋转全屏开启';
    } else if (settingsInstance.enableAutoRotationFullscreen.value && !isLandscape) {
      reason = '当前竖屏 + 自动旋转全屏开启（保持窗口模式）';
    } else {
      reason = '无特殊设置，保持窗口模式';
    }

    return {
      'shouldEnterFullscreen': shouldFullscreen,
      'reason': reason,
      'enableFullScreenDefault': settingsInstance.enableFullScreenDefault.value,
      'enableAutoRotationFullscreen': settingsInstance.enableAutoRotationFullscreen.value,
      'lastExitWasFullscreen': settingsInstance.lastExitWasFullscreen.value,
      'isLandscape': isLandscape,
      'platform': Platform.isIOS
          ? 'iOS'
          : (Platform.isMacOS
              ? 'macOS'
              : (Platform.isAndroid ? 'Android' : 'Other')),
    };
  }

}

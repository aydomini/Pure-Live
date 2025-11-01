import 'dart:io';
import 'package:flutter/material.dart';
import '../style/layout_breakpoints.dart';
import '../style/device_layout_mode.dart';

/// 响应式布局辅助工具类
///
/// 提供设备检测、布局模式判断、弹幕面板宽度计算等功能
class ResponsiveLayoutHelper {
  ResponsiveLayoutHelper._();

  // ==================== 核心方法：获取布局模式 ====================

  /// 获取当前设备布局模式
  ///
  /// [context] - BuildContext，用于获取屏幕尺寸
  /// [isFullscreen] - 是否处于全屏状态，默认为 false
  ///
  /// 返回值：[DeviceLayoutMode] 枚举
  static DeviceLayoutMode getLayoutMode(BuildContext context, {bool isFullscreen = false}) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isLandscape = LayoutBreakpoints.isLandscape(width, height);

    // ==================== 全屏模式优先判断 ====================
    if (isFullscreen) {
      if (Platform.isMacOS) {
        return DeviceLayoutMode.macFullscreen;
      }

      if (Platform.isIOS) {
        if (LayoutBreakpoints.isIPhoneSize(width) || LayoutBreakpoints.isIPhoneSize(height)) {
          return DeviceLayoutMode.iPhoneFullscreen;
        } else {
          return DeviceLayoutMode.iPadFullscreen;
        }
      }
    }

    // ==================== 非全屏模式：根据设备和方向 ====================

    // macOS 平台：始终横屏布局
    if (Platform.isMacOS) {
      return DeviceLayoutMode.macLandscape;
    }

    // iOS 平台：根据设备尺寸和方向
    if (Platform.isIOS) {
      // iPhone：仅支持竖屏模式（横屏时自动进入全屏）
      if (LayoutBreakpoints.isIPhoneSize(width) || LayoutBreakpoints.isIPhoneSize(height)) {
        return DeviceLayoutMode.iPhonePortrait;
      }

      // iPad：支持横屏/竖屏切换
      if (LayoutBreakpoints.isIPadSize(width) || LayoutBreakpoints.isIPadSize(height)) {
        return isLandscape ? DeviceLayoutMode.iPadLandscape : DeviceLayoutMode.iPadPortrait;
      }

      // iPad Pro 或更大尺寸：支持横屏/竖屏切换
      return isLandscape ? DeviceLayoutMode.iPadLandscape : DeviceLayoutMode.iPadPortrait;
    }

    // 默认回退：Mac 横屏
    return DeviceLayoutMode.macLandscape;
  }

  // ==================== 弹幕面板相关 ====================

  /// 获取弹幕面板宽度（自适应计算）
  ///
  /// [mode] - 当前布局模式
  /// [screenWidth] - 屏幕宽度（必需，用于百分比计算）
  ///
  /// 计算逻辑：
  /// - Mac 横屏：屏幕宽度 × 25%，限制在 250-450px 范围内
  /// - iPad 横屏：屏幕宽度 × 28%，限制在 200-350px 范围内
  /// - 其他模式：返回 0（竖屏/全屏不显示侧边栏）
  ///
  /// 示例：
  /// - MacBook Air 13" (1440px) → 1440 × 0.25 = 360px
  /// - iPad Pro 12.9" 横屏 (1366px) → 1366 × 0.28 = 382px → 限制为 350px
  /// - iPad 10.2" 横屏 (1080px) → 1080 × 0.28 = 302px
  static double getDanmakuPanelWidth(DeviceLayoutMode mode, double screenWidth) {
    switch (mode) {
      case DeviceLayoutMode.macLandscape:
        // Mac: 屏幕宽度的 25%，限制在 250-450px
        final width = screenWidth * LayoutBreakpoints.macDanmakuPanelWidthRatio;
        return width.clamp(
          LayoutBreakpoints.macDanmakuPanelMinWidth,
          LayoutBreakpoints.macDanmakuPanelMaxWidth,
        );

      case DeviceLayoutMode.iPadLandscape:
        // iPad: 屏幕宽度的 28%，限制在 200-350px
        final width = screenWidth * LayoutBreakpoints.iPadDanmakuPanelWidthRatio;
        return width.clamp(
          LayoutBreakpoints.iPadDanmakuPanelMinWidth,
          LayoutBreakpoints.iPadDanmakuPanelMaxWidth,
        );

      default:
        // 竖屏和全屏模式不显示侧边栏
        return 0.0;
    }
  }

  /// 获取弹幕面板最小/最大宽度范围
  ///
  /// 返回值：(最小宽度, 最大宽度)
  static (double min, double max) getDanmakuPanelWidthRange(DeviceLayoutMode mode) {
    switch (mode) {
      case DeviceLayoutMode.macLandscape:
        return (
          LayoutBreakpoints.macDanmakuPanelMinWidth,
          LayoutBreakpoints.macDanmakuPanelMaxWidth,
        );

      case DeviceLayoutMode.iPadLandscape:
        return (
          LayoutBreakpoints.iPadDanmakuPanelMinWidth,
          LayoutBreakpoints.iPadDanmakuPanelMaxWidth,
        );

      default:
        return (0.0, 0.0);
    }
  }

  // ==================== 屏幕尺寸判断 ====================

  /// 判断是否为小屏幕（兼容旧代码）
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= LayoutBreakpoints.legacySmallScreenMaxWidth;
  }

  /// 判断是否为宽屏
  static bool isWideScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > LayoutBreakpoints.legacySmallScreenMaxWidth;
  }

  /// 判断是否为 iPhone 尺寸
  static bool isIPhoneSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBreakpoints.isIPhoneSize(size.width) || LayoutBreakpoints.isIPhoneSize(size.height);
  }

  /// 判断是否为 iPad 尺寸
  static bool isIPadSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBreakpoints.isIPadSize(size.width) || LayoutBreakpoints.isIPadSize(size.height);
  }

  /// 判断是否为 Mac 尺寸
  static bool isMacSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBreakpoints.isMacSize(size.width);
  }

  // ==================== 屏幕方向判断 ====================

  /// 判断是否为横屏
  static bool isLandscape(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBreakpoints.isLandscape(size.width, size.height);
  }

  /// 判断是否为竖屏
  static bool isPortrait(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBreakpoints.isPortrait(size.width, size.height);
  }

  /// 获取屏幕方向（Flutter Orientation 枚举）
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  // ==================== 调试工具 ====================

  /// 获取当前布局信息（用于调试）
  static Map<String, dynamic> getLayoutInfo(BuildContext context, {bool isFullscreen = false}) {
    final size = MediaQuery.of(context).size;
    final mode = getLayoutMode(context, isFullscreen: isFullscreen);

    return {
      'platform': Platform.isIOS ? 'iOS' : (Platform.isMacOS ? 'macOS' : 'Other'),
      'screenWidth': size.width,
      'screenHeight': size.height,
      'orientation': getOrientation(context).toString(),
      'isLandscape': isLandscape(context),
      'layoutMode': mode.displayName,
      'isFullscreen': isFullscreen,
      'danmakuPanelWidth': getDanmakuPanelWidth(mode, size.width),
    };
  }

}

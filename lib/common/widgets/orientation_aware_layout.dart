import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/settings_service.dart';

/// 方向感知布局组件
///
/// 功能：
/// 1. 监听屏幕方向变化，自动切换全屏模式
/// 2. 页面初始化时，根据当前方向智能决定初始状态
///
/// 行为：
/// - 竖屏 → 横屏：自动进入全屏
/// - 横屏 → 竖屏：自动退出全屏
/// - 初始化时横屏 + 自动全屏开启：直接进入全屏
///
/// 用法：
/// ```dart
/// OrientationAwareLayout(
///   onInitialOrientationDetected: (isLandscape) {
///     // 页面初始化时的方向检测
///     if (isLandscape && settings.enableAutoRotationFullscreen) {
///       videoController.toggleFullScreen();
///     }
///   },
///   onOrientationChanged: (orientation, isLandscape) {
///     // 后续方向变化处理
///   },
///   child: YourWidget(),
/// )
/// ```
class OrientationAwareLayout extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 初始方向检测回调（页面加载时触发一次）
  /// - [isLandscape]: 初始时是否为横屏
  /// - [orientation]: 初始方向
  final Function(bool isLandscape, Orientation orientation)? onInitialOrientationDetected;

  /// 方向变化回调（方向实际改变时触发）
  /// - [orientation]: 当前方向（Orientation.portrait 或 Orientation.landscape）
  /// - [isLandscape]: 是否为横屏
  final Function(Orientation orientation, bool isLandscape)? onOrientationChanged;

  /// 自动全屏切换回调（传入 VideoController）
  /// - [shouldEnterFullscreen]: true 表示应该进入全屏，false 表示应该退出全屏
  /// - 注意：初始化时不会触发，仅在方向变化时触发
  final Function(bool shouldEnterFullscreen)? onAutoFullscreenToggle;

  /// 是否启用自动全屏切换（默认读取设置）
  final bool? enableAutoFullscreen;

  /// 防抖延迟（毫秒），默认 300ms
  final int debounceMilliseconds;

  const OrientationAwareLayout({
    super.key,
    required this.child,
    this.onInitialOrientationDetected,
    this.onOrientationChanged,
    this.onAutoFullscreenToggle,
    this.enableAutoFullscreen,
    this.debounceMilliseconds = 300,
  });

  @override
  State<OrientationAwareLayout> createState() => _OrientationAwareLayoutState();
}

class _OrientationAwareLayoutState extends State<OrientationAwareLayout> {
  /// 上一次的方向
  Orientation? _lastOrientation;

  /// 防抖定时器
  Timer? _debounceTimer;

  /// 用户是否手动退出过全屏（用于智能判断）
  bool _userManuallyExitedFullscreen = false;

  /// 是否已触发初始化检测
  bool _hasDetectedInitialOrientation = false;

  /// 设置服务
  final SettingsService _settings = Get.find<SettingsService>();

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  /// 处理初始方向检测（页面加载时触发一次）
  void _handleInitialOrientation(Orientation orientation) {
    if (_hasDetectedInitialOrientation) return;
    _hasDetectedInitialOrientation = true;

    final isLandscape = orientation == Orientation.landscape;

    // 触发初始方向检测回调
    widget.onInitialOrientationDetected?.call(isLandscape, orientation);

    // 设置初始方向
    _lastOrientation = orientation;
  }

  /// 处理方向变化
  void _handleOrientationChange(Orientation newOrientation) {
    // 防抖：避免快速旋转时频繁触发
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: widget.debounceMilliseconds), () {
      _processOrientationChange(newOrientation);
    });
  }

  /// 处理方向变化（防抖后）
  void _processOrientationChange(Orientation orientation) {
    // 方向未变化，跳过
    if (_lastOrientation == orientation) {
      print('🔄 OrientationAwareLayout: 方向未变化，跳过 ($orientation)');
      return;
    }

    print('🔄 OrientationAwareLayout: 方向变化 ${_lastOrientation} → $orientation');

    final isLandscape = orientation == Orientation.landscape;

    // 触发回调
    widget.onOrientationChanged?.call(orientation, isLandscape);

    // iOS/Android 平台才支持自动全屏
    if (!Platform.isIOS && !Platform.isAndroid) {
      _lastOrientation = orientation;
      return;
    }

    // 检查是否启用自动全屏
    final enableAuto = widget.enableAutoFullscreen ?? _settings.enableAutoRotationFullscreen.value;
    print('🔄 enableAutoFullscreen: $enableAuto, hasCallback: ${widget.onAutoFullscreenToggle != null}');
    if (!enableAuto || widget.onAutoFullscreenToggle == null) {
      _lastOrientation = orientation;
      return;
    }

    // 自动全屏逻辑
    if (isLandscape) {
      // 竖屏 → 横屏：进入全屏（除非用户手动退出过）
      if (!_userManuallyExitedFullscreen) {
        print('🔄 调用 onAutoFullscreenToggle(true) - 进入全屏');
        widget.onAutoFullscreenToggle?.call(true);
      } else {
        print('🔄 用户手动退出过全屏，跳过自动进入');
      }
    } else {
      // 横屏 → 竖屏：退出全屏
      print('🔄 调用 onAutoFullscreenToggle(false) - 退出全屏');
      widget.onAutoFullscreenToggle?.call(false);
      // 重置手动退出标记
      _userManuallyExitedFullscreen = false;
    }

    _lastOrientation = orientation;
  }

  /// 用户手动退出全屏时调用（需要从外部调用）
  void onUserManuallyExitFullscreen() {
    _userManuallyExitedFullscreen = true;
  }

  /// 重置手动退出标记（例如：用户重新进入播放器页面）
  void resetManualExitFlag() {
    _userManuallyExitedFullscreen = false;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // 使用 WidgetsBinding 确保在布局完成后触发
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // 第一次检测：触发初始化回调
          if (!_hasDetectedInitialOrientation) {
            _handleInitialOrientation(orientation);
          } else {
            // 后续检测：触发方向变化回调
            _handleOrientationChange(orientation);
          }
        });

        return widget.child;
      },
    );
  }
}

/// 简化版：仅监听方向，不处理自动全屏
class OrientationListener extends StatelessWidget {
  final Widget child;
  final Function(Orientation orientation) onOrientationChanged;

  const OrientationListener({
    super.key,
    required this.child,
    required this.onOrientationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onOrientationChanged(orientation);
        });
        return child;
      },
    );
  }
}

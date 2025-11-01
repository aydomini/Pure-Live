/// 设备布局模式枚举
///
/// 根据设备类型和屏幕方向，定义不同的布局模式
enum DeviceLayoutMode {
  // ==================== 横屏-左右分栏（2种） ====================

  /// Mac 横屏模式
  /// - 左侧：视频播放器（Expanded）
  /// - 中间：可调整分割条（250-450px）
  /// - 右侧：弹幕面板（固定宽度）
  macLandscape,

  /// iPad 横屏模式
  /// - 左侧：视频播放器（Expanded）
  /// - 中间：可调整分割条（220-350px）
  /// - 右侧：弹幕面板（固定宽度）
  iPadLandscape,

  // ==================== 竖屏-上下结构（2种） ====================

  /// iPad 竖屏模式
  /// - 上部：视频播放器（16:9 比例，AspectRatio）
  /// - 下部：清晰度选择行 + 弹幕列表（Expanded）
  iPadPortrait,

  /// iPhone 竖屏模式
  /// - 上部：视频播放器（16:9 比例，AspectRatio）
  /// - 下部：清晰度选择行 + 弹幕列表（Expanded）
  /// - 弹幕列表项可能更紧凑
  iPhonePortrait,

  // ==================== 全屏模式（3种，强制横屏） ====================

  /// Mac 全屏模式
  /// - 纯视频播放器，无弹幕面板
  /// - 使用 native fullscreen API
  macFullscreen,

  /// iPad 全屏模式
  /// - 纯视频播放器，无弹幕面板
  /// - 强制锁定横屏方向
  /// - 隐藏系统 UI
  iPadFullscreen,

  /// iPhone 全屏模式
  /// - 纯视频播放器，无弹幕面板
  /// - 强制锁定横屏方向
  /// - 隐藏系统 UI
  iPhoneFullscreen,
}

/// 设备布局模式扩展方法
extension DeviceLayoutModeExtension on DeviceLayoutMode {
  /// 是否为横屏模式（左右分栏）
  bool get isLandscapeMode {
    return this == DeviceLayoutMode.macLandscape || this == DeviceLayoutMode.iPadLandscape;
  }

  /// 是否为竖屏模式（上下结构）
  bool get isPortraitMode {
    return this == DeviceLayoutMode.iPadPortrait || this == DeviceLayoutMode.iPhonePortrait;
  }

  /// 是否为全屏模式
  bool get isFullscreenMode {
    return this == DeviceLayoutMode.macFullscreen ||
        this == DeviceLayoutMode.iPadFullscreen ||
        this == DeviceLayoutMode.iPhoneFullscreen;
  }

  /// 是否显示可调整分割条
  bool get shouldShowResizableDivider {
    return this == DeviceLayoutMode.macLandscape || this == DeviceLayoutMode.iPadLandscape;
  }

  /// 是否为 Mac 平台
  bool get isMacPlatform {
    return this == DeviceLayoutMode.macLandscape || this == DeviceLayoutMode.macFullscreen;
  }

  /// 是否为 iPad
  bool get isIPadDevice {
    return this == DeviceLayoutMode.iPadLandscape ||
        this == DeviceLayoutMode.iPadPortrait ||
        this == DeviceLayoutMode.iPadFullscreen;
  }

  /// 是否为 iPhone
  bool get isIPhoneDevice {
    return this == DeviceLayoutMode.iPhonePortrait || this == DeviceLayoutMode.iPhoneFullscreen;
  }

  /// 获取布局模式名称（用于调试）
  String get displayName {
    switch (this) {
      case DeviceLayoutMode.macLandscape:
        return 'Mac 横屏';
      case DeviceLayoutMode.iPadLandscape:
        return 'iPad 横屏';
      case DeviceLayoutMode.iPadPortrait:
        return 'iPad 竖屏';
      case DeviceLayoutMode.iPhonePortrait:
        return 'iPhone 竖屏';
      case DeviceLayoutMode.macFullscreen:
        return 'Mac 全屏';
      case DeviceLayoutMode.iPadFullscreen:
        return 'iPad 全屏';
      case DeviceLayoutMode.iPhoneFullscreen:
        return 'iPhone 全屏';
    }
  }
}

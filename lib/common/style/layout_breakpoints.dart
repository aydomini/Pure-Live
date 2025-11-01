/// 响应式布局断点常量
///
/// 定义不同设备类型的屏幕宽度断点
class LayoutBreakpoints {
  LayoutBreakpoints._();

  // ==================== 设备类型断点（基于屏幕宽度） ====================

  /// iPhone 最大宽度（竖屏约 375-428px）
  /// 适用于：iPhone SE、iPhone 12/13/14 系列
  static const double iPhoneMaxWidth = 480;

  /// iPad 最小宽度
  /// iPad 竖屏宽度通常 > 480px
  static const double iPadMinWidth = 481;

  /// iPad 最大宽度（竖屏约 768-1024px）
  /// iPad Pro 12.9" 竖屏宽度为 1024px
  static const double iPadMaxWidth = 1024;

  /// Mac 最小宽度
  /// MacBook Air 13" 默认分辨率宽度约 1440px
  static const double macMinWidth = 1025;

  // ==================== 旧断点常量（兼容性保留） ====================

  /// 旧版小屏幕断点（兼容现有代码）
  /// 等同于 iPhoneMaxWidth + iPadMinWidth 的中间值
  static const double legacySmallScreenMaxWidth = 680;

  // ==================== 弹幕面板宽度（自适应） ====================

  /// Mac 横屏 - 弹幕面板宽度占屏幕比例
  /// 例如：1440px 屏幕 × 25% = 360px
  static const double macDanmakuPanelWidthRatio = 0.25;

  /// Mac 横屏 - 弹幕面板最小宽度（防止过小）
  static const double macDanmakuPanelMinWidth = 250;

  /// Mac 横屏 - 弹幕面板最大宽度（防止过大）
  static const double macDanmakuPanelMaxWidth = 450;

  /// iPad 横屏 - 弹幕面板宽度占屏幕比例
  /// 例如：1024px 屏幕 × 28% = 287px
  static const double iPadDanmakuPanelWidthRatio = 0.28;

  /// iPad 横屏 - 弹幕面板最小宽度（防止过小）
  static const double iPadDanmakuPanelMinWidth = 200;

  /// iPad 横屏 - 弹幕面板最大宽度（防止过大）
  static const double iPadDanmakuPanelMaxWidth = 350;

  // ==================== 辅助方法 ====================

  /// 判断是否为 iPhone 尺寸
  static bool isIPhoneSize(double width) => width <= iPhoneMaxWidth;

  /// 判断是否为 iPad 尺寸
  static bool isIPadSize(double width) => width >= iPadMinWidth && width <= iPadMaxWidth;

  /// 判断是否为 Mac 尺寸
  static bool isMacSize(double width) => width >= macMinWidth;

  /// 判断是否为横屏（宽度 >= 高度）
  static bool isLandscape(double width, double height) => width >= height;

  /// 判断是否为竖屏（高度 > 宽度）
  static bool isPortrait(double width, double height) => height > width;
}

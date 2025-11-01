import 'package:flutter/material.dart';

/// 可调整大小的分隔条组件
/// 用于在两个组件之间提供可拖动的分隔线，允许用户调整布局比例
class ResizableDivider extends StatefulWidget {
  /// 当前宽度
  final double width;

  /// 最小宽度
  final double minWidth;

  /// 最大宽度
  final double maxWidth;

  /// 宽度变化回调
  final ValueChanged<double> onResize;

  /// 分隔条颜色
  final Color? color;

  /// 分隔条宽度
  final double thickness;

  const ResizableDivider({
    super.key,
    required this.width,
    required this.minWidth,
    required this.maxWidth,
    required this.onResize,
    this.color,
    this.thickness = 4.0,
  });

  @override
  State<ResizableDivider> createState() => _ResizableDividerState();
}

class _ResizableDividerState extends State<ResizableDivider> {
  bool _isHovering = false;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onHorizontalDragStart: (_) => setState(() => _isDragging = true),
        onHorizontalDragUpdate: (details) {
          // 根据拖动距离计算新宽度
          final newWidth = widget.width - details.delta.dx;

          // 限制在最小和最大宽度之间
          if (newWidth >= widget.minWidth && newWidth <= widget.maxWidth) {
            widget.onResize(newWidth);
          }
        },
        onHorizontalDragEnd: (_) => setState(() => _isDragging = false),
        child: Container(
          width: widget.thickness,
          color: _isDragging
              ? Theme.of(context).colorScheme.primary
              : _isHovering
                  ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
                  : widget.color ?? Theme.of(context).dividerColor,
          child: Center(
            child: Container(
              width: 2,
              color: _isHovering || _isDragging
                  ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.3)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:pure_live/common/index.dart';
import 'package:pure_live/pkg/canvas_danmaku/danmaku_screen.dart';
import 'package:pure_live/pkg/canvas_danmaku/models/danmaku_option.dart';
import 'package:pure_live/modules/live_play/widgets/video_player/volume_control.dart';
import 'package:pure_live/modules/live_play/widgets/video_player/video_controller.dart';
import 'package:pure_live/modules/live_play/live_play_controller.dart';

class VideoControllerPanel extends StatefulWidget {
  final VideoController controller;

  const VideoControllerPanel({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _VideoControllerPanelState();
}

class _VideoControllerPanelState extends State<VideoControllerPanel> {
  static const barHeight = 56.0;

  // Video controllers
  VideoController get controller => widget.controller;
  double currentVolumn = 1.0;
  bool showVolumn = true;
  Timer? _hideVolumn;
  void restartTimer() {
    _hideVolumn?.cancel();
    _hideVolumn = Timer(const Duration(seconds: 1), () {
      setState(() => showVolumn = true);
    });
    setState(() => showVolumn = false);
  }

  @override
  void dispose() {
    _hideVolumn?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.enableController();
    });
  }

  void updateVolumn(double? volume) {
    restartTimer();
    setState(() {
      currentVolumn = volume!;
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    iconData = currentVolumn <= 0
        ? Icons.volume_mute
        : currentVolumn < 0.5
        ? Icons.volume_down
        : Icons.volume_up;
    return Material(
      type: MaterialType.transparency,
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.mediaPlay): () => controller.mediaPlayerController.player.play(),
          const SingleActivator(LogicalKeyboardKey.mediaPause): () => controller.mediaPlayerController.player.pause(),
          const SingleActivator(LogicalKeyboardKey.mediaPlayPause): () =>
              controller.mediaPlayerController.player.playOrPause(),
          const SingleActivator(LogicalKeyboardKey.space): () => controller.mediaPlayerController.player.playOrPause(),
          const SingleActivator(LogicalKeyboardKey.keyR): () => controller.refresh(),
          const SingleActivator(LogicalKeyboardKey.arrowUp): () async {
            double? volume = 1.0;
            volume = await controller.volume();
            volume = (volume! + 0.05);
            volume = min(volume, 1.0);
            volume = max(volume, 0.0);
            controller.setVolume(volume);
            updateVolumn(volume);
          },
          const SingleActivator(LogicalKeyboardKey.arrowDown): () async {
            double? volume = 1.0;
            volume = await controller.volume();
            volume = (volume! - 0.05);
            volume = min(volume, 1.0);
            volume = max(volume, 0.0);
            controller.setVolume(volume);
            updateVolumn(volume);
          },
          const SingleActivator(LogicalKeyboardKey.escape): () {
            // ESC 键行为：优先退出全屏，而不是切换全屏
            if (controller.isWindowFullscreen.value) {
              controller.toggleWindowFullScreen();
            } else if (controller.isFullscreen.value) {
              controller.toggleFullScreen();
            }
            // 如果不在全屏状态，ESC 键不执行任何操作
          },
        },
        child: Focus(
          autofocus: true,
          child: Obx(
            () => controller.hasError.value
                ? ErrorWidget(controller: controller)
                : MouseRegion(
                    onHover: (event) => controller.enableController(),
                    cursor: !controller.showController.value ? SystemMouseCursors.none : SystemMouseCursors.basic,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: AnimatedOpacity(
                            opacity: !showVolumn ? 0.8 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Card(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(iconData, color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 4),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          width: 100,
                                          height: 20,
                                          child: LinearProgressIndicator(
                                            value: currentVolumn,
                                            backgroundColor: Colors.white38,
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).tabBarTheme.indicatorColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        DanmakuViewer(controller: controller),
                        GestureDetector(
                          onTap: () {
                            if (controller.showSettting.value) {
                              controller.showSettting.toggle();
                            } else {
                              controller.isPlaying.value ? controller.enableController() : controller.togglePlayPause();
                            }
                          },
                          onDoubleTap: () => controller.isWindowFullscreen.value
                              ? controller.toggleWindowFullScreen()
                              : controller.toggleFullScreen(),
                          child: BrightnessVolumnDargArea(controller: controller),
                        ),
                        SettingsPanel(controller: controller),
                        LockButton(controller: controller),
                        TopActionBar(controller: controller, barHeight: barHeight),
                        BottomActionBar(controller: controller, barHeight: barHeight),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(S.of(context).play_video_failed, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
          ElevatedButton(
            onPressed: () => controller.refresh(),
            style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.white.withValues(alpha: 0.2)),
            child: Text(S.of(context).retry, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Top action bar widgets
class TopActionBar extends StatelessWidget {
  const TopActionBar({super.key, required this.controller, required this.barHeight});

  final VideoController controller;
  final double barHeight;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        top:
            (!controller.isPipMode.value &&
                !controller.showSettting.value &&
                controller.showController.value &&
                !controller.showLocked.value)
            ? 0
            : -barHeight,
        left: 0,
        right: 0,
        height: barHeight,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: barHeight,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.transparent, Colors.black45],
            ),
          ),
          child: Row(
            children: [
              if (controller.fullscreenUI) BackButton(controller: controller),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          controller.room.title!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),
                        ),
                      ),
                      // 🔥 热度组件（紧靠房间标题）
                      if (controller.room.watching != null && controller.room.watching!.isNotEmpty && controller.room.watching != '0') ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.whatshot_rounded, size: 16, color: Colors.red),
                        const SizedBox(width: 4),
                        Text(
                          readableCount(controller.room.watching!),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (controller.fullscreenUI) ...[
                const DatetimeInfo(),
                // 电量显示仅在移动平台显示（Android/iOS）
                if (Platform.isAndroid || Platform.isIOS) BatteryInfo(controller: controller),
              ],
              if (!controller.fullscreenUI && controller.supportPip) PIPButton(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class DatetimeInfo extends StatefulWidget {
  const DatetimeInfo({super.key});

  @override
  State<DatetimeInfo> createState() => _DatetimeInfoState();
}

class _DatetimeInfoState extends State<DatetimeInfo> {
  DateTime dateTime = DateTime.now();
  Timer? refreshDateTimer;

  @override
  void initState() {
    super.initState();
    refreshDateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() => dateTime = DateTime.now());
    });
  }

  @override
  void dispose() {
    super.dispose();
    refreshDateTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // get system time and format
    var hour = dateTime.hour.toString();
    if (hour.length < 2) hour = '0$hour';
    var minute = dateTime.minute.toString();
    if (minute.length < 2) minute = '0$minute';

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Text(
        '$hour:$minute',
        style: const TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.none),
      ),
    );
  }
}

class BatteryInfo extends StatefulWidget {
  const BatteryInfo({super.key, required this.controller});

  final VideoController controller;

  @override
  State<BatteryInfo> createState() => _BatteryInfoState();
}

class _BatteryInfoState extends State<BatteryInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      child: Container(
        width: 35,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.4),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Obx(
            () => Text(
              '${widget.controller.batteryLevel.value}',
              style: const TextStyle(color: Colors.white, fontSize: 9, decoration: TextDecoration.none),
            ),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 直接退出播放页面，无论是否在全屏状态
        // Flutter 会自动处理全屏状态的恢复
        Navigator.of(Get.context!).pop();
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
      ),
    );
  }
}

class PIPButton extends StatelessWidget {
  const PIPButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.enterPipMode(context),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: const Icon(CustomIcons.float_window, color: Colors.white),
      ),
    );
  }
}

// Center widgets
class DanmakuViewer extends StatelessWidget {
  const DanmakuViewer({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DanmakuScreen(
        controller: controller.danmakuController,
        option: DanmakuOption(
          fontSize: controller.danmakuFontSize.value,
          topArea: controller.danmakuTopArea.value,
          bottomArea: controller.danmakuBottomArea.value,
          duration: controller.danmakuSpeed.value.toInt(),
          opacity: controller.danmakuOpacity.value,
          fontWeight: controller.danmakuFontBorder.value.toInt(),
        ),
      ),
    );
  }
}

class BrightnessVolumnDargArea extends StatefulWidget {
  const BrightnessVolumnDargArea({super.key, required this.controller});

  final VideoController controller;

  @override
  State<BrightnessVolumnDargArea> createState() => BrightnessVolumnDargAreaState();
}

class BrightnessVolumnDargAreaState extends State<BrightnessVolumnDargArea> {
  VideoController get controller => widget.controller;

  // Darg bv ui control
  Timer? _hideBVTimer;
  bool _hideBVStuff = true;
  bool _isDargLeft = true;
  double _updateDargVarVal = 1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _hideBVTimer?.cancel();
    super.dispose();
  }

  void updateVolumn(double? volume) {
    _isDargLeft = false;
    _cancelAndRestartHideBVTimer();
    setState(() {
      _updateDargVarVal = volume!;
    });
  }

  void _cancelAndRestartHideBVTimer() {
    _hideBVTimer?.cancel();
    _hideBVTimer = Timer(const Duration(seconds: 1), () {
      setState(() => _hideBVStuff = true);
    });
    setState(() => _hideBVStuff = false);
  }

  void _onVerticalDragUpdate(Offset postion, Offset delta) async {
    if (controller.showLocked.value) return;
    if (delta.distance < 0.2) return;

    // fix darg left change to switch bug
    final width = MediaQuery.of(context).size.width;
    final dargLeft = (postion.dx > (width / 2)) ? false : true;
    // disable windows brightness
    if (Platform.isWindows && dargLeft) return;
    if (_hideBVStuff || _isDargLeft != dargLeft) {
      _isDargLeft = dargLeft;
      if (_isDargLeft) {
        await controller.brightness().then((double v) {
          setState(() => _updateDargVarVal = v);
        });
      } else {
        await controller.volume().then((double? v) {
          setState(() => _updateDargVarVal = v!);
        });
      }
    }
    _cancelAndRestartHideBVTimer();

    double dragRange = (delta.direction < 0 || delta.direction > pi)
        ? _updateDargVarVal + 0.01
        : _updateDargVarVal - 0.01;
    // 是否溢出
    dragRange = min(dragRange, 1.0);
    dragRange = max(dragRange, 0.0);
    // 亮度 & 音量
    if (_isDargLeft) {
      controller.setBrightness(dragRange);
    } else {
      controller.setVolume(dragRange);
    }
    setState(() => _updateDargVarVal = dragRange);
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    if (_isDargLeft) {
      iconData = _updateDargVarVal <= 0
          ? Icons.brightness_low
          : _updateDargVarVal < 0.5
          ? Icons.brightness_medium
          : Icons.brightness_high;
    } else {
      iconData = _updateDargVarVal <= 0
          ? Icons.volume_mute
          : _updateDargVarVal < 0.5
          ? Icons.volume_down
          : Icons.volume_up;
    }

    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          _onVerticalDragUpdate(event.localPosition, event.scrollDelta);
        }
      },
      child: GestureDetector(
        onVerticalDragUpdate: (details) => _onVerticalDragUpdate(details.localPosition, details.delta),
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: AnimatedOpacity(
            opacity: !_hideBVStuff ? 0.8 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(iconData, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 100,
                          height: 20,
                          child: LinearProgressIndicator(
                            value: _updateDargVarVal,
                            backgroundColor: Colors.white38,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LockButton extends StatelessWidget {
  const LockButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedOpacity(
        opacity:
            (!controller.isPipMode.value &&
                !controller.showSettting.value &&
                controller.fullscreenUI &&
                controller.showController.value)
            ? 0.9
            : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Align(
          alignment: Alignment.centerRight,
          child: AbsorbPointer(
            absorbing: !controller.showController.value,
            child: Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () => controller.toggleLock(),
                icon: Icon(controller.showLocked.value ? Icons.lock_rounded : Icons.lock_open_rounded, size: 28),
                color: Colors.white,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black38,
                  shape: const StadiumBorder(),
                  minimumSize: const Size(50, 50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Bottom action bar widgets
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.controller, required this.barHeight});

  final VideoController controller;
  final double barHeight;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        bottom:
            (!controller.isPipMode.value &&
                !controller.showSettting.value &&
                controller.showController.value &&
                !controller.showLocked.value)
            ? 0
            : -barHeight,
        left: 0,
        right: 0,
        height: barHeight,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: barHeight,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black45],
            ),
          ),
          child: Row(
            children: <Widget>[
              PlayPauseButton(controller: controller),
              RefreshButton(controller: controller),
              DanmakuButton(controller: controller),
              SettingsButton(controller: controller),
              const Spacer(),
              VideoFitSetting(controller: controller),
              SizedBox(width: 8),
              QualityButton(controller: controller),
              SizedBox(width: 8),
              OverlayVolumeControl(controller: controller),
              SizedBox(width: 8),
              if (controller.supportWindowFull && !controller.isFullscreen.value)
                ExpandWindowButton(controller: controller),
              if (controller.supportWindowFull && !controller.isFullscreen.value) SizedBox(width: 8),
              if (!controller.isWindowFullscreen.value) ExpandButton(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.togglePlayPause(),
      child: Obx(
        () => Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          child: Icon(controller.isPlaying.value ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white),
        ),
      ),
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.refresh(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: const Icon(Icons.refresh_rounded, color: Colors.white),
      ),
    );
  }
}

class DanmakuButton extends StatelessWidget {
  const DanmakuButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.hideDanmaku.toggle(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => controller.hideDanmaku.value
              ? SvgPicture.asset(
                  'assets/images/video/danmu_close.svg',
                  // ignore: deprecated_member_use
                  color: Colors.white,
                )
              : SvgPicture.asset(
                  'assets/images/video/danmu_open.svg',
                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.showSettting.toggle(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          'assets/images/video/danmu_setting.svg',
          // ignore: deprecated_member_use
          color: Colors.white,
        ),
      ),
    );
  }
}

class ExpandWindowButton extends StatelessWidget {
  const ExpandWindowButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.toggleWindowFullScreen(),
      child: Container(
        alignment: Alignment.center,
        child: RotatedBox(
          quarterTurns: 1,
          child: Obx(
            () => Icon(
              controller.isWindowFullscreen.value ? Icons.unfold_less_rounded : Icons.unfold_more_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.toggleFullScreen(),
      child: Container(
        alignment: Alignment.center,
        child: Obx(
          () => Icon(
            controller.isFullscreen.value ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }
}

// Settings panel widgets
class SettingsPanel extends StatelessWidget {
  const SettingsPanel({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    // 🔧 统一弹窗宽度：不区分竖屏横屏，使用固定合理宽度
    final screenWidth = MediaQuery.of(context).size.width;
    final width = (screenWidth * 0.5).clamp(300.0, 400.0);

    return Obx(
      () => AnimatedPositioned(
        top: 0,
        bottom: 0,
        right: controller.showSettting.value ? 0 : -width,
        width: width,
        duration: const Duration(milliseconds: 200),
        child: Card(
          color: Colors.black.withValues(alpha: 0.8),
          child: SizedBox(
            width: width,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [DanmakuSetting(controller: controller)],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoFitSetting extends StatelessWidget {
  const VideoFitSetting({super.key, required this.controller});
  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    List<String> descs = controller.videoFitType.map((e) => e['desc'] as String).toList();
    List<BoxFit> attrs = controller.videoFitType.map((e) => e['attr'] as BoxFit).toList();

    return GestureDetector(
      onTap: () {
        // 显示弹出菜单
        final RenderBox button = context.findRenderObject() as RenderBox;
        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            button.localToGlobal(Offset.zero, ancestor: overlay),
            button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
          ),
          Offset.zero & overlay.size,
        );

        showMenu<int>(
          context: context,
          position: position,
          color: Colors.black.withValues(alpha: 0.9), // 使用深色半透明背景，确保白色文字清晰可读
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          items: List.generate(descs.length, (i) {
            final isSelected = controller.videoFitIndex.value == i;
            return PopupMenuItem<int>(
              value: i,
              child: Text(
                descs[i],
                style: TextStyle(
                  color: isSelected ? Get.theme.colorScheme.primary : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            );
          }),
        ).then((value) {
          if (value != null) {
            controller.videoFitIndex.value = value;
            controller.setVideoFit(attrs[value]);
          }
        });
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: Text(
          S.of(context).aspect_ratio,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

class DanmakuSetting extends StatelessWidget {
  const DanmakuSetting({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    const TextStyle label = TextStyle(color: Colors.white);
    const TextStyle digit = TextStyle(color: Colors.white);

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Text(
              S.of(context).settings_danmaku_title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ),
          // 弹幕显示区域选择
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).danmaku_display_area, style: label),
                const SizedBox(height: 8),
                Row(
                  children: [
                    for (int i = 0; i < SettingsService.danmakuAreaModes.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(
                            SettingsService.danmakuAreaModes[i]['name'],
                            style: TextStyle(
                              color: controller.settings.danmakuAreaMode.value == i
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                              fontSize: 12,
                            ),
                          ),
                          selected: controller.settings.danmakuAreaMode.value == i,
                          onSelected: (selected) {
                            if (selected) {
                              controller.settings.setDanmakuAreaMode(i);
                            }
                          },
                          selectedColor: Theme.of(context).colorScheme.primary,
                          // 未选中状态：使用深色背景和明显边框，提高在深色面板上的可见性
                          backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
                          // 使用主题色边框，与选中状态形成视觉关联
                          side: BorderSide(
                            color: controller.settings.danmakuAreaMode.value == i
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.outline,
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // 🔧 优化布局：使用两行式布局，标签和数值在上，滑块在下
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).settings_danmaku_opacity, style: label),
                    Text('${(controller.danmakuOpacity.value * 100).toInt()}%', style: digit),
                  ],
                ),
                Slider(
                  divisions: 10,
                  min: 0.0,
                  max: 1.0,
                  value: controller.danmakuOpacity.value,
                  onChanged: (val) => controller.danmakuOpacity.value = val,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).settings_danmaku_speed, style: label),
                    Text(controller.danmakuSpeed.value.toInt().toString(), style: digit),
                  ],
                ),
                Slider(
                  divisions: 15,
                  min: 5.0,
                  max: 20.0,
                  value: controller.danmakuSpeed.value,
                  onChanged: (val) => controller.danmakuSpeed.value = val,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).settings_danmaku_fontsize, style: label),
                    Text(controller.danmakuFontSize.value.toInt().toString(), style: digit),
                  ],
                ),
                Slider(
                  divisions: 20,
                  min: 10.0,
                  max: 30.0,
                  value: controller.danmakuFontSize.value,
                  onChanged: (val) => controller.danmakuFontSize.value = val,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).settings_danmaku_fontBorder, style: label),
                    Text(controller.danmakuFontBorder.value.toStringAsFixed(2), style: digit),
                  ],
                ),
                Slider(
                  divisions: 8,
                  min: 0.0,
                  max: 8.0,
                  value: controller.danmakuFontBorder.value,
                  onChanged: (val) => controller.danmakuFontBorder.value = val,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Quality button with nested popup menu
class QualityButton extends StatelessWidget {
  const QualityButton({super.key, required this.controller});

  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    // 需要获取 LivePlayController 来访问清晰度和线路信息
    final liveController = Get.find<LivePlayController>();

    return Obx(
      () {
        // 如果没有清晰度数据，不显示按钮
        if (liveController.qualites.isEmpty) {
          return const SizedBox.shrink();
        }

        // 获取当前清晰度
        final currentQuality = liveController.qualites[liveController.currentQuality.value].quality;

        return GestureDetector(
          onTap: () {
            // 显示弹出菜单
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
            final RelativeRect position = RelativeRect.fromRect(
              Rect.fromPoints(
                button.localToGlobal(Offset.zero, ancestor: overlay),
                button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
              ),
              Offset.zero & overlay.size,
            );

            final items = <PopupMenuEntry<Map<String, dynamic>>>[];

            for (int i = 0; i < liveController.qualites.length; i++) {
              final quality = liveController.qualites[i];
              final isCurrentQuality = quality.quality == currentQuality;

              // 添加清晰度标题
              items.add(
                PopupMenuItem<Map<String, dynamic>>(
                  enabled: false,
                  child: Text(
                    quality.quality,
                    style: TextStyle(
                      color: isCurrentQuality ? Get.theme.colorScheme.primary : Colors.white,
                      fontWeight: isCurrentQuality ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              );

              // 添加线路选项
              for (int j = 0; j < liveController.playUrls.length; j++) {
                final isCurrentLine = isCurrentQuality && j == liveController.currentLineIndex.value;
                items.add(
                  PopupMenuItem<Map<String, dynamic>>(
                    value: {'quality': quality.quality, 'lineIndex': j.toString()},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        '线路${j + 1}',
                        style: TextStyle(
                          color: isCurrentLine ? Get.theme.colorScheme.primary : Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }

              // 添加分隔线（除了最后一个）
              if (i < liveController.qualites.length - 1) {
                items.add(const PopupMenuDivider(height: 8));
              }
            }

            showMenu<Map<String, dynamic>>(
              context: context,
              position: position,
              color: Colors.black.withValues(alpha: 0.9), // 使用深色半透明背景，确保白色文字清晰可读
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              items: items,
            ).then((data) {
              if (data != null) {
                final quality = data['quality'] as String;
                final lineIndex = data['lineIndex'] as String;
                liveController.setResolution(quality, lineIndex);
              }
            });
          },
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            child: Text(
              S.of(context).quality,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}

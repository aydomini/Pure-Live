import 'dart:io';
import 'dart:async';
import 'widgets/index.dart';
import 'package:get/get.dart';
import 'package:pure_live/common/index.dart';
import 'package:pure_live/plugins/event_bus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:pure_live/modules/live_play/play_other.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pure_live/modules/live_play/live_play_controller.dart';
import 'package:pure_live/common/widgets/orientation_aware_layout.dart';
import 'package:pure_live/common/utils/responsive_layout_helper.dart';
import 'package:pure_live/common/utils/fullscreen_helper.dart';
import 'package:pure_live/common/style/device_layout_mode.dart';

class LivePlayPage extends GetView<LivePlayController> {
  LivePlayPage({super.key});

  final SettingsService settings = Get.find<SettingsService>();

  // 保存初始横屏状态，用于延迟进入全屏（使用响应式变量）
  final RxBool _shouldEnterFullscreenOnInit = false.obs;

  Future<bool> onWillPop({bool directiveExit = false}) async {
    try {
      var exit = await controller.onBackPressed(directiveExit: directiveExit);
      if (exit) {
        Navigator.of(Get.context!).pop();
      }
    } catch (e) {
      Navigator.of(Get.context!).pop();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (settings.enableScreenKeepOn.value) {
      WakelockPlus.toggle(enable: settings.enableScreenKeepOn.value);
    }
    return Obx(() {
      var currentPlayIndex =
          controller.currentSite.id == Sites.huyaSite && controller.settings.videoPlayerIndex.value == 1
          ? 0
          : controller.settings.videoPlayerIndex.value;

      // 🔧 修复：获取当前屏幕方向，竖屏时不显示全屏
      final orientation = MediaQuery.of(context).orientation;
      final isPortrait = orientation == Orientation.portrait;
      final shouldShowFullscreen = controller.isFullScreen.value && !isPortrait;

      return BackButtonListener(
        onBackButtonPressed: () => onWillPop(directiveExit: false),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (Widget child, Animation<double> animation) {
            // 只使用淡入淡出，移除缩放避免布局错位
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: currentPlayIndex == 1
              ? buildNormalPlayerView(context)
              : shouldShowFullscreen
              ? DesktopFullscreen(
                  key: const ValueKey('fullscreen'),
                  controller: controller.videoController!,
                )
              : buildNormalPlayerView(context),
        ),
      );
    });
  }

  Scaffold buildNormalPlayerView(BuildContext context) {
    // 🔧 修复：检测全屏状态，全屏时立即隐藏 AppBar（避免切换过程中的布局破坏感）
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;
    final shouldShowFullscreen = controller.isFullScreen.value && !isPortrait;

    return Scaffold(
      appBar: shouldShowFullscreen ? null : AppBar(
        title: Obx(
          () => controller.getVideoSuccess.value
              ? Row(
                  children: [
                    CircleAvatar(
                      foregroundImage: controller.detail.value == null && controller.detail.value!.avatar!.isEmpty
                          ? null
                          : NetworkImage(controller.detail.value!.avatar!),
                      radius: 13,
                      backgroundColor: Theme.of(context).disabledColor,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 120),
                          child: Text(
                            controller.detail.value == null && controller.detail.value!.nick == null
                                ? ''
                                : controller.detail.value!.nick!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        if (controller.detail.value != null && controller.detail.value!.area != null)
                          Text(
                            controller.detail.value!.area!.isEmpty
                                ? controller.detail.value!.platform!.toUpperCase()
                                : "${controller.detail.value!.platform!.toUpperCase()} / ${controller.detail.value!.area}",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 8),
                          ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => controller.getVideoSuccess.value
                          ? FavoriteFloatingButton(room: controller.detail.value!)
                          : FavoriteFloatingButton(room: controller.currentPlayRoom.value),
                    ),
                  ],
                )
              : Row(
                  children: [
                    CircleAvatar(
                      foregroundImage: controller.currentPlayRoom.value.avatar == null
                          ? null
                          : NetworkImage(controller.currentPlayRoom.value.avatar!),
                      radius: 13,
                      backgroundColor: Theme.of(context).disabledColor,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 120),
                          child: Text(
                            controller.detail.value == null && controller.detail.value!.nick == null
                                ? ''
                                : controller.detail.value!.nick!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        Text(
                          controller.currentPlayRoom.value.area!.isEmpty
                              ? controller.currentPlayRoom.value.platform!.toUpperCase()
                              : "${controller.currentPlayRoom.value.platform!.toUpperCase()} / ${controller.currentPlayRoom.value.area}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 8),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => controller.getVideoSuccess.value
                          ? FavoriteFloatingButton(room: controller.detail.value!)
                          : FavoriteFloatingButton(room: controller.currentPlayRoom.value),
                    ),
                  ],
                ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz_outlined),
            tooltip: '切换直播间',
            onPressed: () {
              Get.dialog(PlayOther(controller: controller));
            },
          ),
          PopupMenuButton(
            tooltip: '搜索',
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            offset: const Offset(12, 0),
            position: PopupMenuPosition.under,
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (int index) {
              if (index == 0) {
                controller.openNaviteAPP();
              } else if (index == 1) {
                showDlnaCastDialog();
              } else if (index == 2) {
                showTimerDialog(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MenuListTile(leading: Icon(Icons.open_in_new_rounded), text: "打开直播间"),
                ),
                const PopupMenuItem(
                  value: 1,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MenuListTile(leading: Icon(Icons.live_tv_rounded), text: "投屏"),
                ),
                const PopupMenuItem(
                  value: 2,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MenuListTile(leading: Icon(Icons.watch_later_outlined), text: "定时关闭"),
                ),
              ];
            },
          ),
        ],
      ),
      body: OrientationAwareLayout(
        // ====================  初始化检测 ====================
        onInitialOrientationDetected: (isLandscape, orientation) {
          // 页面加载时触发一次，决定初始全屏状态

          // 使用 FullscreenHelper 智能判断是否应该全屏
          final shouldEnterFullscreen = FullscreenHelper.shouldEnterFullscreenOnInit(
            isLandscape: isLandscape,
          );
          final isIPhone = Platform.isIOS && ResponsiveLayoutHelper.isIPhoneSize(context);
          final isIPad = Platform.isIOS && !isIPhone;

          if (shouldEnterFullscreen && isIPad) {
            // iPad 默认保留分栏体验，不在初始化时自动全屏
            print('📱 iPad 初始化横屏，跳过默认全屏');
            return;
          }

          if (shouldEnterFullscreen) {
            // 保存状态，等待视频控制器就绪后进入全屏
            _shouldEnterFullscreenOnInit.value = true;

            // 尝试立即进入全屏（如果控制器已就绪）
            _tryEnterFullscreenOnInit();

            // 同时监听控制器初始化（以防控制器还未创建）
            _monitorVideoControllerForFullscreen();
          }
        },

        // ====================  方向变化监听 ====================
        onAutoFullscreenToggle: (shouldEnterFullscreen) {
          // 后续方向变化时自动触发
          final videoController = controller.videoController;
          if (videoController == null) {
            print('❌ videoController is null');
            return;
          }

          final mediaQuery = MediaQuery.of(context);
          final orientation = mediaQuery.orientation;
          final isIPhone = Platform.isIOS && ResponsiveLayoutHelper.isIPhoneSize(context);
          final isIPad = Platform.isIOS && !isIPhone;

          print('🎬 onAutoFullscreenToggle: shouldEnter=$shouldEnterFullscreen, orientation=$orientation, '
              'isManualControlMode=${videoController.isManualControlMode.value}, '
              'isManualFullscreenToggle=${videoController.isManualFullscreenToggle.value}, '
              'isFullscreen=${videoController.isFullscreen.value}');

          // 竖屏：确保退出全屏，iPhone 强制恢复状态栏
          if (!shouldEnterFullscreen) {
            if (videoController.isFullscreen.value) {
              if (isIPhone || !videoController.isManualControlMode.value) {
                print('✅ 调用 exitFullScreen()');
                videoController.exitFullScreen();
              } else {
                print('❌ 手动控制模式，不自动退出全屏');
              }
            }
            return;
          }

          // iPad 横屏采用分栏布局，跳过自动全屏
          if (isIPad) {
            print('📱 iPad 横屏使用分栏布局，跳过自动全屏');
            return;
          }

          // 手动控制与防抖保护
          if (videoController.isManualControlMode.value) {
            print('❌ 手动控制模式，跳过自动全屏');
            return;
          }
          if (videoController.isManualFullscreenToggle.value) {
            print('❌ 手动切换中（防抖），跳过自动全屏');
            return;
          }

          if (!videoController.isFullscreen.value) {
            // 横屏 → 自动进入全屏（传入 isManual: false）
            print('✅ 调用 toggleFullScreen(isManual: false)');
            videoController.toggleFullScreen(isManual: false);
          }
        },

        // ====================  子组件（响应式布局） ====================
        child: Builder(
          builder: (BuildContext context) {
            return LayoutBuilder(
              builder: (context, constraint) {
                // 获取当前布局模式
                final layoutMode = ResponsiveLayoutHelper.getLayoutMode(
                  context,
                  isFullscreen: controller.videoController?.isFullscreen.value ?? false,
                );

                // 获取屏幕宽度（用于自适应弹幕面板宽度）
                final screenWidth = MediaQuery.of(context).size.width;

                // 根据布局模式渲染不同UI
                return SafeArea(
                  child: _buildLayoutByMode(layoutMode, screenWidth, context),
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// 根据布局模式构建UI
  Widget _buildLayoutByMode(DeviceLayoutMode mode, double screenWidth, BuildContext context) {
    // 🔧 修复黑屏bug：增加方向检查，竖屏时即使 isFullscreenMode 也显示正常布局
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    // 全屏模式：只有横屏全屏才不显示（全屏由 DesktopFullscreen 组件处理）
    if (mode.isFullscreenMode && !isPortrait) {
      // 横屏全屏模式已在 build() 方法中处理
      return const SizedBox.shrink();
    }

    // 竖屏或非全屏模式：显示正常布局

    // 🔧 响应式断点：宽度 < 768px 时强制使用上下布局（防止弹幕面板挤压播放器）
    final isNarrowScreen = screenWidth < 768;

    // 竖屏上下结构（iPhone/iPad 竖屏）
    if (mode.isPortraitMode || mode == DeviceLayoutMode.iPhonePortrait) {
      return Column(
        children: <Widget>[
          buildVideoPlayer(),
          Expanded(child: Obx(() => DanmakuListView(room: controller.detail.value!))),
        ],
      );
    }

    // 🔧 窄屏强制上下布局（宽度 < 768px）
    if (isNarrowScreen) {
      return Column(
        children: <Widget>[
          buildVideoPlayer(),
          Expanded(child: Obx(() => DanmakuListView(room: controller.detail.value!))),
        ],
      );
    }

    // 横屏左右分栏（Mac/iPad 横屏，宽度 >= 768px）
    if (mode.isLandscapeMode) {
      // 🎯 自适应计算弹幕面板宽度（不允许用户手动调整）
      final danmakuWidth = ResponsiveLayoutHelper.getDanmakuPanelWidth(mode, screenWidth);

      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 垂直方向拉伸填充
        children: <Widget>[
          Expanded(child: buildVideoPlayer()),
          VerticalDivider(width: 1, thickness: 1),
          SizedBox(
            width: danmakuWidth,
            child: Obx(() => DanmakuListView(room: controller.detail.value!)),
          ),
        ],
      );
    }

    // 默认回退：竖屏上下结构
    return Column(
      children: <Widget>[
        buildVideoPlayer(),
        Expanded(child: Obx(() => DanmakuListView(room: controller.detail.value!))),
      ],
    );
  }

  void showDlnaCastDialog() {
    Get.dialog(LiveDlnaPage(datasource: controller.playUrls[controller.currentLineIndex.value]));
  }

  Widget buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        child: Obx(
          () => controller.success.value
              ? VideoPlayer(controller: controller.videoController!)
              : controller.hasError.value && controller.isActive.value == false || !controller.getVideoSuccess.value
              ? ErrorVideoWidget(controller: controller)
              : videoInfo(),
        ),
      ),
    );
  }

  Card videoInfo() {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      clipBehavior: Clip.antiAlias,
      color: Get.theme.focusColor,
      child: Obx(
        () => controller.isFirstLoad.value || !controller.loadTimeOut.value
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : controller.loadTimeOut.value
            ? CachedNetworkImage(
                imageUrl: controller.currentPlayRoom.value.cover!,
                cacheManager: CustomCacheManager.instance,
                fit: BoxFit.fill,
                errorWidget: (context, error, stackTrace) => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.live_tv_rounded, size: 48),
                      Text("无法获取播放信息", style: TextStyle(color: Colors.white, fontSize: 18)),
                      Text("当前房间未开播或无法观看", style: TextStyle(color: Colors.white, fontSize: 18)),
                      Text("请刷新重试", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                ),
              )
            : TimeOutVideoWidget(controller: controller),
      ),
    );
  }

  void showTimerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text(S.of(context).auto_refresh_time),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text(S.of(context).timed_close),
                contentPadding: EdgeInsets.zero,
                value: controller.closeTimeFlag.value,
                activeThumbColor: Theme.of(context).colorScheme.primary,
                onChanged: (bool value) => controller.closeTimeFlag.value = value,
              ),
              Slider(
                min: 0,
                max: 240,
                label: S.of(context).auto_refresh_time,
                value: controller.closeTimes.toDouble(),
                onChanged: (value) => controller.closeTimes.value = value.toInt(),
              ),
              Text(
                '自动关闭时间:'
                ' ${controller.closeTimes}分钟',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 尝试立即进入全屏（如果控制器已就绪）
  void _tryEnterFullscreenOnInit() {
    if (!_shouldEnterFullscreenOnInit.value) return;

    final videoController = controller.videoController;
    if (videoController == null) {
      return;
    }


    // 如果视频已初始化，立即进入全屏
    if (videoController.mediaPlayerControllerInitialized.value &&
        videoController.datasource.isNotEmpty &&
        !videoController.isFullscreen.value) {
      videoController.toggleFullScreen(isManual: false); // 自动初始化，不算手动
      _shouldEnterFullscreenOnInit.value = false; // 清除标记
    } else {
    }
  }

  /// 监听视频控制器初始化，一旦准备好就进入全屏
  void _monitorVideoControllerForFullscreen() {
    if (!_shouldEnterFullscreenOnInit.value) return;

    // 延迟检查，给控制器创建时间
    Future.delayed(const Duration(milliseconds: 100), () {
      _checkAndEnterFullscreen();
    });
  }

  /// 检查视频是否准备好，如果是则进入全屏
  void _checkAndEnterFullscreen() {
    if (!_shouldEnterFullscreenOnInit.value) return;

    final videoController = controller.videoController;
    if (videoController == null) {
      // 继续等待
      Future.delayed(const Duration(milliseconds: 200), () {
        _checkAndEnterFullscreen();
      });
      return;
    }

    // 监听视频初始化状态
    if (videoController.mediaPlayerControllerInitialized.value &&
        videoController.datasource.isNotEmpty &&
        !videoController.isFullscreen.value) {
      videoController.toggleFullScreen();
      _shouldEnterFullscreenOnInit.value = false; // 清除标记
    } else {
      // 等待视频初始化（最多等待 3 秒）
      int attempts = 0;
      Timer.periodic(const Duration(milliseconds: 300), (timer) {
        attempts++;
        final vc = controller.videoController;

        if (!_shouldEnterFullscreenOnInit.value || vc == null) {
          timer.cancel();
          return;
        }

        if (vc.mediaPlayerControllerInitialized.value &&
            vc.datasource.isNotEmpty &&
            !vc.isFullscreen.value) {
          vc.toggleFullScreen(isManual: false); // 自动初始化，不算手动
          _shouldEnterFullscreenOnInit.value = false;
          timer.cancel();
        } else if (attempts >= 10) {
          _shouldEnterFullscreenOnInit.value = false;
          timer.cancel();
        }
      });
    }
  }
}

class ResolutionsRow extends StatefulWidget {
  const ResolutionsRow({super.key});

  @override
  State<ResolutionsRow> createState() => _ResolutionsRowState();
}

class _ResolutionsRowState extends State<ResolutionsRow> {
  LivePlayController get controller => Get.find();
  Widget buildInfoCount() {
    // controller.detail.value! watching or followers
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.whatshot_rounded, size: 14),
        const SizedBox(width: 4),
        Text(readableCount(controller.detail.value!.watching!), style: Get.textTheme.bodySmall),
      ],
    );
  }

  List<Widget> buildResultionsList() {
    return controller.qualites
        .map<Widget>(
          (rate) => PopupMenuButton(
            tooltip: rate.quality,
            color: Get.theme.colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            offset: const Offset(0.0, 5.0),
            position: PopupMenuPosition.under,
            icon: Text(
              rate.quality,
              style: Get.theme.textTheme.labelSmall?.copyWith(
                color: rate.quality == controller.qualites[controller.currentQuality.value].quality
                    ? Get.theme.colorScheme.primary
                    : null,
              ),
            ),
            onSelected: (String index) {
              controller.setResolution(rate.quality, index);
            },
            itemBuilder: (context) {
              final items = <PopupMenuItem<String>>[];
              final urls = controller.playUrls;
              for (int i = 0; i < urls.length; i++) {
                items.add(
                  PopupMenuItem<String>(
                    value: i.toString(),
                    child: Text(
                      '线路${i + 1}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: urls[i] == controller.playUrls[controller.currentLineIndex.value]
                            ? Get.theme.colorScheme.primary
                            : null,
                      ),
                    ),
                  ),
                );
              }
              return items;
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 55,
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            const Spacer(),
            ...controller.success.value ? buildResultionsList() : [],
          ],
        ),
      ),
    );
  }
}

class FavoriteFloatingButton extends StatefulWidget {
  const FavoriteFloatingButton({super.key, required this.room});

  final LiveRoom room;

  @override
  State<FavoriteFloatingButton> createState() => _FavoriteFloatingButtonState();
}

class _FavoriteFloatingButtonState extends State<FavoriteFloatingButton> {
  StreamSubscription<dynamic>? subscription;

  @override
  void initState() {
    super.initState();
    listenFavorite();
  }

  void listenFavorite() {
    subscription = EventBus.instance.listen('changeFavorite', (data) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsService>();
    bool isFavorite = settings.isFavorite(widget.room);
    return isFavorite
        ? FilledButton(
            style: ButtonStyle(
              // 减小内边距，使按钮更小
              padding: Platform.isWindows
                  ? WidgetStateProperty.all(EdgeInsets.all(12.0))
                  : WidgetStateProperty.all(EdgeInsets.all(5.0)),
              // 设置背景色
              backgroundColor: WidgetStateProperty.all(Get.theme.colorScheme.primary.withAlpha(125)),
              // 设置按钮形状，调整圆角半径
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0), // 圆角半径，可根据需要调整
                ),
              ),
              // 可选：减小文字大小
              textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 12.0)),
              minimumSize: WidgetStateProperty.all(Size.zero), // 移除默认最小尺寸
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text(S.of(context).unfollow),
                  content: Text(S.of(context).unfollow_message(widget.room.nick!)),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(Get.context!).pop(false);
                      },
                      child: Text(S.of(context).cancel),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(Get.context!).pop(true);
                      },
                      child: Text(S.of(context).confirm),
                    ),
                  ],
                ),
              ).then((value) {
                if (value) {
                  setState(() => isFavorite = !isFavorite);
                  settings.removeRoom(widget.room);
                  EventBus.instance.emit('changeFavorite', true);
                }
              });
            },
            child: Text(S.of(context).followed),
          )
        : FilledButton(
            style: ButtonStyle(
              // 减小内边距，使按钮更小
              padding: Platform.isWindows
                  ? WidgetStateProperty.all(EdgeInsets.all(12.0))
                  : WidgetStateProperty.all(EdgeInsets.all(5.0)),
              // 设置背景色
              backgroundColor: WidgetStateProperty.all(Get.theme.colorScheme.primary),
              // 设置按钮形状，调整圆角半径
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0), // 圆角半径，可根据需要调整
                ),
              ),
              // 可选：减小文字大小
              textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 12.0)),
              minimumSize: WidgetStateProperty.all(Size.zero), // 移除默认最小尺寸
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              setState(() => isFavorite = !isFavorite);
              settings.addRoom(widget.room);
              EventBus.instance.emit('changeFavorite', true);
            },
            child: Text(S.of(context).follow),
          );
  }
}

class ErrorVideoWidget extends StatelessWidget {
  const ErrorVideoWidget({super.key, required this.controller});

  final LivePlayController controller;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => Text(
                '${controller.currentPlayRoom.value.platform == Sites.iptvSite ? controller.currentPlayRoom.value.title : controller.currentPlayRoom.value.nick ?? ''}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).play_video_failed,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const Text("所有线路已切换且无法播放", style: TextStyle(color: Colors.white, fontSize: 14)),
                  const Text("请切换播放器或设置解码方式刷新重试", style: TextStyle(color: Colors.white, fontSize: 14)),
                  const Text("如仍有问题可能该房间未开播或无法观看", style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeOutVideoWidget extends StatelessWidget {
  const TimeOutVideoWidget({super.key, required this.controller});

  final LivePlayController controller;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => Text(
                '${controller.currentPlayRoom.value.platform == Sites.iptvSite ? controller.currentPlayRoom.value.title : controller.currentPlayRoom.value.nick ?? ''}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).play_video_failed,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const Text("该房间未开播或已下播", style: TextStyle(color: Colors.white, fontSize: 14)),
                  const Text("请刷新或者切换其他直播间进行观看吧", style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

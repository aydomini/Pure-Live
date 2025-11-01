import 'dart:io';
import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'video_controller_panel.dart';
import 'package:flutter/services.dart';
import 'package:floating/floating.dart';
import 'package:pure_live/common/index.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:pure_live/modules/live_play/load_type.dart';
import 'package:pure_live/pkg/canvas_danmaku/danmaku_controller.dart';
import 'package:pure_live/modules/live_play/live_play_controller.dart';
import 'package:pure_live/pkg/canvas_danmaku/models/danmaku_option.dart';
import 'package:media_kit_video/media_kit_video.dart' as media_kit_video;
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:pure_live/pkg/canvas_danmaku/models/danmaku_content_item.dart';
import 'package:pure_live/modules/live_play/widgets/video_player/fullscreen.dart';

class VideoController with ChangeNotifier {
  final LiveRoom room;
  final String datasourceType;
  String datasource;
  final bool allowBackgroundPlay;
  final bool allowScreenKeepOn;
  final bool allowFullScreen;
  final bool fullScreenByDefault;
  final bool autoPlay;
  final Map<String, String> headers;

  final int videoPlayerIndex;
  final isVertical = false.obs;
  final videoFitIndex = 0.obs;
  final videoFit = BoxFit.contain.obs;
  final mediaPlayerControllerInitialized = false.obs;

  ScreenBrightness brightnessController = ScreenBrightness();

  double initBrightness = 0.0;

  final String qualiteName;

  final int currentLineIndex;

  final int currentQuality;

  final hasError = false.obs;

  final isPlaying = false.obs;

  final isBuffering = false.obs;

  final isPipMode = false.obs;

  final isFullscreen = false.obs;

  final isWindowFullscreen = false.obs;

  bool hasDestory = false;

  bool get supportPip => Platform.isAndroid;

  bool get supportWindowFull => Platform.isWindows || Platform.isLinux;

  bool get fullscreenUI => isFullscreen.value || isWindowFullscreen.value;

  final videoSizeWidth = 0.0.obs;

  final videoSizeHeight = 0.0.obs;

  // ignore: prefer_typing_uninitialized_variables
  late final Floating pip;
  // Video player status
  // A [GlobalKey<VideoState>] is required to access the programmatic fullscreen interface.
  late final GlobalKey<media_kit_video.VideoState> key = GlobalKey<media_kit_video.VideoState>();

  // Create a [Player] to control playback.
  late Player player;
  // CeoController] to handle video output from [Player].
  late media_kit_video.VideoController mediaPlayerController;
  // BetterPlayerController? mobileController;  // 已移除 BetterPlayer
  final playerRefresh = false.obs;

  GlobalKey<BrightnessVolumnDargAreaState> brightnessKey = GlobalKey<BrightnessVolumnDargAreaState>();

  LivePlayController livePlayController = Get.find<LivePlayController>();

  final SettingsService settings = Get.find<SettingsService>();

  bool enableCodec = true;

  bool playerCompatMode = false;

  // 是否手动暂停
  var isActivePause = true.obs;

  Timer? hasActivePause;

  // Controller ui status
  ///State of navigator on widget created
  late NavigatorState navigatorState;

  ///Flag which determines if widget has initialized

  Timer? showControllerTimer;
  final showController = true.obs;
  final showSettting = false.obs;
  final showLocked = false.obs;
  final danmuKey = GlobalKey();

  GlobalKey playerKey = GlobalKey();
  // 精简为3个最常用的比例选项（适合macOS/iOS直播场景）
  List<Map<String, dynamic>> videoFitType = [
    {'attr': BoxFit.contain, 'desc': S.current.video_fit_contain},  // 完整显示，保持比例，有黑边
    {'attr': BoxFit.cover, 'desc': S.current.video_fit_cover},    // 填满屏幕，保持比例，可能裁剪
    {'attr': BoxFit.fill, 'desc': S.current.video_fit_fill},     // 拉伸填满，不保持比例
  ];
  Timer? _debounceTimer;
  StreamSubscription? _widthSubscription;
  StreamSubscription? _heightSubscription;
  void enableController() {
    showControllerTimer?.cancel();
    showControllerTimer = Timer(const Duration(seconds: 2), () {
      showController.value = false;
    });
    showController.value = true;
  }

  final hideDanmaku = false.obs;
  final danmakuAreaMode = 0.obs; // 0=全屏，1=1/2屏，2=1/4屏
  final danmakuTopArea = 0.0.obs;
  final danmakuBottomArea = 0.0.obs;
  final danmakuSpeed = 8.0.obs;
  final danmakuFontSize = 16.0.obs;
  final danmakuFontBorder = 4.0.obs;
  final danmakuOpacity = 1.0.obs;

  // 🔧 防止手动点击全屏按钮和自动旋转全屏冲突（临时防抖）
  final isManualFullscreenToggle = false.obs;

  // 🔧 手动控制模式：用户点击全屏按钮后，禁用自动旋转全屏，直到退出播放器
  final isManualControlMode = false.obs;
  VideoController({
    required this.room,
    required this.datasourceType,
    required this.datasource,
    required this.headers,
    this.allowBackgroundPlay = false,
    this.allowScreenKeepOn = false,
    this.allowFullScreen = true,
    this.fullScreenByDefault = false,
    this.autoPlay = true,
    BoxFit fitMode = BoxFit.contain,
    required this.qualiteName,
    required this.currentLineIndex,
    required this.currentQuality,
    required this.videoPlayerIndex,
  }) {
    danmakuController = DanmakuController(
      onAddDanmaku: (item) {},
      onUpdateOption: (option) {},
      onPause: () {},
      onResume: () {},
      onClear: () {},
    );

    // 确保索引不超出范围（精简选项后，旧的索引3-5可能无效）
    videoFitIndex.value = settings.videoFitIndex.value;
    if (videoFitIndex.value >= videoFitType.length) {
      videoFitIndex.value = 0; // 重置为默认值（包含）
    }
    videoFit.value = settings.videofitArrary[videoFitIndex.value];
    hideDanmaku.value = settings.hideDanmaku.value;
    danmakuAreaMode.value = settings.danmakuAreaMode.value;
    danmakuTopArea.value = settings.danmakuTopArea.value;
    danmakuBottomArea.value = settings.danmakuBottomArea.value;
    danmakuSpeed.value = settings.danmakuSpeed.value;
    danmakuFontSize.value = settings.danmakuFontSize.value;
    danmakuFontBorder.value = settings.danmakuFontBorder.value;
    danmakuOpacity.value = settings.danmakuOpacity.value;

    // macOS/Windows：初始化时重置全屏状态为 false，因为系统可能保持全屏但播放器是新创建的
    if (Platform.isMacOS || Platform.isWindows) {
      isFullscreen.value = false;
      log('🔄 初始化VideoController，重置isFullscreen为false', name: 'fullscreen_state');

      // 监听 isFullscreen 变化，实时保存状态
      isFullscreen.listen((value) {
        if (Platform.isMacOS || Platform.isWindows) {
          settings.lastExitWasFullscreen.value = value;
          log('💾 实时保存全屏状态: $value', name: 'fullscreen_state');
          if (value) {
            SmartDialog.showToast('✅ 已进入全屏，将记住此状态');
          }
        }
      });
    }

    initPagesConfig();
  }

  void initPagesConfig() {
    if (allowScreenKeepOn) WakelockPlus.enable();
    initVideoController();
    initDanmaku();
    initBattery();
  }

  // Battery level control
  final Battery _battery = Battery();
  final batteryLevel = 100.obs;

  late DanmakuController danmakuController;
  void initBattery() {
    if (Platform.isAndroid || Platform.isIOS) {
      _battery.batteryLevel.then((value) => batteryLevel.value = value);
      _battery.onBatteryStateChanged.listen((BatteryState state) async {
        batteryLevel.value = await _battery.batteryLevel;
      });
    }
  }

  void initVideoController() async {
    FlutterVolumeController.updateShowSystemUI(false);
    registerVolumeListener();
    if (videoPlayerIndex == 0 || Platform.isWindows) {
      enableCodec = settings.enableCodec.value;
      playerCompatMode = settings.playerCompatMode.value;
      player = Player();
      if (player.platform is NativePlayer) {
        (player.platform as dynamic).setProperty('cache', 'no'); // --cache=<yes|no|auto>
        (player.platform as dynamic).setProperty('cache-secs', '0'); // --cache-secs=<seconds> with cache but why not.
        (player.platform as dynamic).setProperty('demuxer-seekable-cache', 'no');
        (player.platform as dynamic).setProperty('demuxer-max-back-bytes', '0'); // --demuxer-max-back-bytes=<bytesize>
        (player.platform as dynamic).setProperty('demuxer-donate-buffer', 'no'); // --demuxer-donate-buffer==<yes|no>
        if (settings.customPlayerOutput.value) {
          (player.platform as dynamic).setProperty('ao', settings.audioOutputDriver.value);
        }
      }
      mediaPlayerController = media_kit_video.VideoController(
        player,
        configuration: settings.customPlayerOutput.value
            ? VideoControllerConfiguration(
                vo: settings.videoOutputDriver.value,
                hwdec: settings.videoHardwareDecoder.value,
              )
            : playerCompatMode
            ? VideoControllerConfiguration(vo: 'mediacodec_embed', hwdec: 'mediacodec')
            : Platform.isMacOS
            ? VideoControllerConfiguration(
                // macOS 使用软件渲染，避免 OpenGL/Metal 库加载问题
                enableHardwareAcceleration: false,
              )
            : VideoControllerConfiguration(
                enableHardwareAcceleration: enableCodec,
                androidAttachSurfaceAfterVideoParameters: false,
              ),
      );
      setDataSource(datasource);
      mediaPlayerController.player.stream.playing.listen((bool playing) {
        isPlaying.value = playing;
        if (playing && mediaPlayerControllerInitialized.value == false) {
          mediaPlayerControllerInitialized.value = true;
          setVolume(settings.volume.value);
        }
      });
      mediaPlayerController.player.stream.error.listen((event) {
        if (event.toString().contains('Failed to open')) {
          hasError.value = true;
          isPlaying.value = false;
        }
      });
      _widthSubscription = player.stream.width.listen((event) {
        isVertical.value = (player.state.height ?? 9) > (player.state.width ?? 16);
      });
      _heightSubscription = player.stream.height.listen((event) {
        isVertical.value = (player.state.height ?? 9) > (player.state.width ?? 16);
      });
      debounce(hasError, (callback) {
        if (hasError.value && !livePlayController.isLastLine.value) {
          SmartDialog.showToast("视频播放失败,正在为您切换线路");
          changeLine();
        }
      }, time: const Duration(seconds: 2));

      showController.listen((p0) {
        if (showController.value) {
          if (isPlaying.value) {
            isActivePause.value = false;
          }
        }
        if (isPlaying.value) {
          hasActivePause?.cancel();
        }
      });

      isPlaying.listen((p0) {
        // 代表手动暂停了
        if (!isPlaying.value) {
          if (showController.value) {
            isActivePause.value = true;
            hasActivePause?.cancel();
          } else {
            if (isActivePause.value) {
              hasActivePause = Timer(const Duration(seconds: 20), () {
                // 暂停了
                SmartDialog.showToast("系统监测视频已停止播放,正在为您刷新视频");
                isActivePause.value = false;
                refresh();
              });
            }
          }
        } else {
          hasActivePause?.cancel();
          isActivePause.value = false;
        }
      });

      mediaPlayerControllerInitialized.listen((value) {
        // 桌面平台（macOS/Windows）：检查上次退出时的全屏状态，自动恢复全屏
        // 移动平台（Android/iOS）：仍使用 fullScreenByDefault 设置
        bool shouldEnterFullscreen = false;
        if (Platform.isMacOS || Platform.isWindows) {
          shouldEnterFullscreen = settings.lastExitWasFullscreen.value;
          log('🔍 检查全屏状态 - lastExitWasFullscreen: $shouldEnterFullscreen, currentFullscreen: ${isFullscreen.value}',
              name: 'fullscreen_state');
        } else {
          shouldEnterFullscreen = fullScreenByDefault;
        }

        if (shouldEnterFullscreen && datasource.isNotEmpty && value) {
          log('✅ 准备恢复全屏模式', name: 'fullscreen_state');
          SmartDialog.showToast('🎬 正在恢复全屏模式...');
          Timer(const Duration(milliseconds: 500), () {
            log('🎬 执行 toggleFullScreen()', name: 'fullscreen_state');
            toggleFullScreen(isManual: false); // 恢复全屏是自动的
          });
        } else {
          log('❌ 不恢复全屏 - shouldEnter: $shouldEnterFullscreen, datasource: ${datasource.isNotEmpty}, initialized: $value',
              name: 'fullscreen_state');
        }
      });
      if (Platform.isAndroid) {
        pip = Floating();
        pip.pipStatusStream.listen((status) async {
          if (status == PiPStatus.enabled) {
            isPipMode.value = true;
          } else {
            isPipMode.value = false;
            isFullscreen.value = false;
            doExitFullScreen();
          }
        });
      }
    }
    /* ========================================
     * BetterPlayer (Exo播放器) 已移除
     * 项目现在只支持 macOS/iOS，统一使用 media_kit
     * ======================================== */
    /* else {
      mobileController = BetterPlayerController(
        BetterPlayerConfiguration(
          controlsConfiguration: BetterPlayerControlsConfiguration(
            playerTheme: BetterPlayerTheme.custom,
            customControlsBuilder: (controller, onControlsVisibilityChanged) => VideoControllerPanel(controller: this),
          ),
          autoPlay: true,
          fit: videoFit.value,
          allowedScreenSleep: !allowScreenKeepOn,
          autoDetectFullscreenDeviceOrientation: true,
          autoDetectFullscreenAspectRatio: true,
          errorBuilder: (context, errorMessage) => Container(),
          handleLifecycle: true,
        ),
      );
      mobileController?.setControlsEnabled(false);
      setDataSource(datasource);

      mobileController?.addEventsListener(mobileStateListener);
      mediaPlayerControllerInitialized.listen((value) {
        if (fullScreenByDefault && datasource.isNotEmpty && value) {
          Timer(const Duration(milliseconds: 500), () => toggleFullScreen());
        }
      });
      debounce(hasError, (callback) {
        if (hasError.value && !livePlayController.isLastLine.value) {
          SmartDialog.showToast("视频播放失败,正在为您切换线路");
          changeLine();
        }
      }, time: const Duration(seconds: 2));

      showController.listen((p0) {
        if (showController.value) {
          if (isPlaying.value) {
            isActivePause.value = false;
          }
        }
        if (isPlaying.value) {
          hasActivePause?.cancel();
        }
      });

      isPlaying.listen((p0) {
        // 代表手动暂停了
        if (!isPlaying.value) {
          if (showController.value) {
            isActivePause.value = true;
            hasActivePause?.cancel();
          } else {
            if (isActivePause.value) {
              hasActivePause = Timer(const Duration(seconds: 20), () {
                // 暂停了
                SmartDialog.showToast("系统监测视频已停止播放,正在为您刷新视频");
                isActivePause.value = false;
                refresh();
              });
            }
          }
        } else {
          hasActivePause?.cancel();
          isActivePause.value = false;
        }
      });
    } */
  }

  /* dynamic mobileStateListener(BetterPlayerEvent event) {
    if (mobileController?.videoPlayerController != null) {
      hasError.value = mobileController?.videoPlayerController?.value.hasError ?? false;
      isPlaying.value = mobileController?.isPlaying() ?? false;
      isBuffering.value = mobileController?.isBuffering() ?? false;
      isPipMode.value = mobileController?.videoPlayerController?.value.isPip ?? false;
      if (isPlaying.value && mediaPlayerControllerInitialized.value == false) {
        mediaPlayerControllerInitialized.value = true;
        setVolume(settings.volume.value);
        isVertical.value =
            (mobileController?.videoPlayerController!.value.size!.height ?? 9) >
            (mobileController?.videoPlayerController!.value.size!.width ?? 16);
      }
    }
  } */

  void debounceListen(Function? func, [int delay = 1000]) {
    if (_debounceTimer != null) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(Duration(milliseconds: delay), () {
      func?.call();
      _debounceTimer = null;
    });
  }

  void initDanmaku() {
    hideDanmaku.value = PrefUtil.getBool('hideDanmaku') ?? false;
    hideDanmaku.listen((data) {
      if (data) {
        danmakuController.clear();
      }
      PrefUtil.setBool('hideDanmaku', data);
      settings.hideDanmaku.value = data;
    });
    // topArea 和 bottomArea 由 settings.danmakuAreaMode 控制，这里只监听变化用于更新弹幕显示
    danmakuTopArea.listen((data) {
      updateDanmaku();
    });
    danmakuBottomArea.listen((data) {
      updateDanmaku();
    });

    // 监听 settings 的 topArea 和 bottomArea 变化，同步到 controller
    settings.danmakuTopArea.listen((data) {
      danmakuTopArea.value = data;
    });
    settings.danmakuBottomArea.listen((data) {
      danmakuBottomArea.value = data;
    });
    danmakuSpeed.value = PrefUtil.getDouble('danmakuSpeed') ?? 8;
    danmakuSpeed.listen((data) {
      PrefUtil.setDouble('danmakuSpeed', data);
      settings.danmakuSpeed.value = data;
      updateDanmaku();
    });
    danmakuFontSize.value = PrefUtil.getDouble('danmakuFontSize') ?? 16;
    danmakuFontSize.listen((data) {
      PrefUtil.setDouble('danmakuFontSize', data);
      settings.danmakuFontSize.value = data;
      updateDanmaku();
    });
    danmakuFontBorder.value = PrefUtil.getDouble('danmakuFontBorder') ?? 4.0;
    danmakuFontBorder.listen((data) {
      PrefUtil.setDouble('danmakuFontBorder', data);
      settings.danmakuFontBorder.value = data;
      updateDanmaku();
    });
    danmakuOpacity.value = PrefUtil.getDouble('danmakuOpacity') ?? 1.0;
    danmakuOpacity.listen((data) {
      PrefUtil.setDouble('danmakuOpacity', data);
      settings.danmakuOpacity.value = data;
      updateDanmaku();
    });
  }

  void updateDanmaku() {
    danmakuController.updateOption(
      DanmakuOption(
        fontSize: danmakuFontSize.value,
        topArea: danmakuTopArea.value,
        bottomArea: danmakuBottomArea.value,
        duration: danmakuSpeed.value.toInt(),
        opacity: danmakuOpacity.value,
        fontWeight: danmakuFontBorder.value.toInt(),
      ),
    );
  }

  void sendDanmaku(LiveMessage msg) {
    if (hideDanmaku.value) return;
    if (isPlaying.value) {
      danmakuController.addDanmaku(
        DanmakuContentItem(msg.message, color: Color.fromARGB(255, msg.color.r, msg.color.g, msg.color.b)),
      );
    }
  }

  @override
  void dispose() async {
    if (hasDestory == false) {
      await destory();
    }
    super.dispose();
  }

  void refresh() async {
    await destory();
    Timer(const Duration(seconds: 2), () {
      livePlayController.onInitPlayerState(reloadDataType: ReloadDataType.refreash);
    });
  }

  void changeLine({bool active = false}) async {
    // 播放错误 不一定是线路问题 先切换路线解决 后面尝试通知用户切换播放器
    await destory();
    Timer(const Duration(seconds: 2), () {
      livePlayController.onInitPlayerState(
        reloadDataType: ReloadDataType.changeLine,
        line: currentLineIndex,
        active: active,
      );
    });
  }

  Future<void> destory() async {
    isPlaying.value = false;
    hasError.value = false;
    livePlayController.success.value = false;
    hasDestory = true;
    _widthSubscription?.cancel();
    _heightSubscription?.cancel();
    if (allowScreenKeepOn) WakelockPlus.disable();

    // 🔧 退出播放器时，重置手动控制模式（恢复自动旋转功能）
    isManualControlMode.value = false;
    isManualFullscreenToggle.value = false;

    FlutterVolumeController.removeListener();
    if (Platform.isAndroid || Platform.isIOS) {
      brightnessController.resetApplicationScreenBrightness();

      // 🔧 解锁方向限制（无论是否全屏，都要解锁）
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);

      if (isFullscreen.value) {
        // if (videoPlayerIndex == 1) {
        //   mobileController?.exitFullScreen();
        // } else {
          doExitFullScreen();
        // }
      }
      // if (videoPlayerIndex == 0) {
        player.dispose();
      // } else {
      //   mobileController?.dispose();
      // }
    } else {
      // macOS/Windows：返回时不退出全屏，保持系统全屏状态
      // if (isFullscreen.value) {
      //   doExitFullScreen();
      // }
      player.dispose();
    }
    // macOS/Windows 在返回时保持全屏状态，不重置 isFullscreen
    if (Platform.isAndroid || Platform.isIOS) {
      isFullscreen.value = false;
    }
  }

  void setDataSource(String url) async {
    datasource = url;
    // fix datasource empty error
    if (datasource.isEmpty) {
      hasError.value = true;
      return;
    } else {
      hasError.value = false;
    }
    if (Platform.isWindows || videoPlayerIndex == 0) {
      player.pause();
      player.open(Media(datasource, httpHeaders: headers));
    }
    /* else {
      BetterPlayerVideoFormat? videoFormat;
      if (room.platform == Sites.bilibiliSite) {
        videoFormat = BetterPlayerVideoFormat.hls;
      }
      if (room.platform == Sites.huyaSite) {
        if (url.contains('.m3u8')) {
          videoFormat = BetterPlayerVideoFormat.hls;
        }
      }

      final result = await mobileController?.setupDataSource(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          url,
          videoFormat: videoFormat,
          liveStream: true,
          notificationConfiguration: allowBackgroundPlay
              ? BetterPlayerNotificationConfiguration(
                  showNotification: true,
                  title: room.title,
                  author: room.nick,
                  imageUrl: room.avatar,
                  activityName: "MainActivity",
                )
              : null,
          headers: headers,
          bufferingConfiguration: BetterPlayerBufferingConfiguration(),
          cacheConfiguration: BetterPlayerCacheConfiguration(
            useCache: false, // 禁用缓存
          ),
        ),
      );
      log(result.toString(), name: 'video_player');
    } */
    notifyListeners();
  }

  void setVideoFit(BoxFit fit) {
    videoFit.value = fit;
    settings.videoFitIndex.value = videoFitIndex.value;
    // if (videoPlayerIndex == 1) {
    //   mobileController?.setOverriddenFit(videoFit.value);
    //   mobileController?.retryDataSource();
    // }
  }

  void togglePlayPause() {
    // if (Platform.isWindows || videoPlayerIndex == 0) {
      mediaPlayerController.player.playOrPause();
    // } else {
    //   isPlaying.value ? mobileController!.pause() : mobileController!.play();
    // }
  }

  void exitFullScreen() {
    // if (videoPlayerIndex == 1) {
    //   Future.delayed(const Duration(milliseconds: 100), () {
    //     mobileController?.exitFullScreen();
    //   });
    // } else {
      doExitFullScreen();
    // }
    isFullscreen.value = false;
    showSettting.value = false;
  }

  /// 设置横屏
  Future setLandscapeOrientation() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  /// 设置竖屏
  Future setPortraitOrientation() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  void toggleFullScreen({bool isManual = true}) async {
    print('🎬 toggleFullScreen: isManual=$isManual, currentFullscreen=${isFullscreen.value}');

    // 🔧 只有手动点击时才设置手动控制模式
    if (isManual) {
      isManualFullscreenToggle.value = true;
      isManualControlMode.value = true;
      print('🎬 手动模式：isManualControlMode=true');
    } else {
      isManualFullscreenToggle.value = true;
      print('🎬 自动模式：仅设置防抖标志');
    }

    // 🔧 修复：不再强制解除旋转锁定，保留用户的锁定偏好
    // showLocked.value = false;  // ❌ 已移除
    showControllerTimer?.cancel();
    Timer(const Duration(seconds: 2), () {
      enableController();
    });

    if (isFullscreen.value) {
      // ========== 退出全屏 ==========
      isFullscreen.value = false;

      // 🔧 退出全屏时，重置手动控制模式（恢复自动旋转检测）
      isManualControlMode.value = false;

      // 移动端：退出全屏时的方向控制
      if (Platform.isIOS || Platform.isAndroid) {
        // 如果用户已锁定旋转，保持锁定状态；否则引导回竖屏
        if (!showLocked.value) {
          // 未锁定：先强制竖屏，300ms后解锁所有方向
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);

          Future.delayed(const Duration(milliseconds: 300), () {
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          });
        } else {
          // 已锁定：不改变方向设置
        }

        await doExitFullScreen();
      } else {
        await doExitFullScreen();
      }

      // 400ms后清除临时防抖标志
      Future.delayed(const Duration(milliseconds: 400), () {
        isManualFullscreenToggle.value = false;
      });
    } else {
      // ========== 进入全屏 ==========
      await doEnterFullScreen();
      isFullscreen.value = true;

      // 移动端：根据旋转锁定状态和当前方向处理
      if (Platform.isIOS || Platform.isAndroid) {
        if (showLocked.value) {
          // 已锁定：保持当前锁定状态，不改变方向
        } else {
          // 未锁定：检测当前方向并优化引导
          final context = Get.context;
          if (context != null && context.mounted) {
            final currentOrientation = MediaQuery.of(context).orientation;

            if (currentOrientation == Orientation.portrait) {
              // 当前竖屏，引导横屏
              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);

              // 🔧 修复：手动全屏时，锁定横屏方向，不自动解锁
              // 只有在非手动模式（自动全屏）时才解锁
              if (!isManual) {
                // 自动全屏：500ms后解锁，允许跟随设备旋转
                Future.delayed(const Duration(milliseconds: 500), () {
                  SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                });
              }
              // 手动全屏：保持锁定，直到用户点击退出全屏或旋转锁定
            } else {
              // 已经横屏
              if (isManual) {
                // 手动全屏：锁定横屏
                await SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              } else {
                // 自动全屏：允许所有方向
                await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              }
            }
          }
        }

        // 统一：600ms后清除防抖标志
        Future.delayed(const Duration(milliseconds: 600), () {
          isManualFullscreenToggle.value = false;
        });
      } else {
        // 桌面端立即清除标志
        Future.delayed(const Duration(milliseconds: 100), () {
          isManualFullscreenToggle.value = false;
        });
      }
    }
  }

  void toggleWindowFullScreen() {
    // disable locked
    showLocked.value = false;
    // fix obx setstate when build
    showControllerTimer?.cancel();
    Timer(const Duration(seconds: 2), () {
      enableController();
    });

    if (Platform.isWindows || Platform.isLinux) {
      if (!isWindowFullscreen.value) {
        Get.to(() => DesktopFullscreen(controller: this, key: UniqueKey()));
      } else {
        Navigator.of(Get.context!).pop();
      }
      isWindowFullscreen.toggle();
    } else {
      throw UnimplementedError('Unsupported Platform');
    }
    enableController();
  }

  /// 切换旋转锁定（仅移动平台）
  void toggleLock() async {
    // 仅在移动平台（Android/iOS）上生效
    if (!Platform.isAndroid && !Platform.isIOS) {
      return;
    }

    // 切换锁定状态
    showLocked.toggle();

    if (showLocked.value) {
      // 锁定：获取当前方向并固定
      final context = Get.context;
      if (context != null) {
        final currentOrientation = MediaQuery.of(context).orientation;

        if (currentOrientation == Orientation.landscape) {
          // 当前横屏，锁定到横屏
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        } else {
          // 当前竖屏，锁定到竖屏
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
      }
    } else {
      // 解锁：允许所有方向
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }

  void enterPipMode(BuildContext context) async {
    if ((Platform.isAndroid || Platform.isIOS)) {
      danmakuController.clear();
      danmakuController.resume();
      if (Platform.isWindows || videoPlayerIndex == 0) {
        isFullscreen.toggle();
        if (isVertical.value) {
          await verticalScreen();
        }
        doEnterFullScreen();
        await pip.enable(ImmediatePiP());
      }
      // else {
      //   if (await mobileController?.isPictureInPictureSupported() ?? false) {
      //     isPipMode.value = true;
      //     mobileController?.enablePictureInPicture(playerKey);
      //   }
      // }

    }
  }

  // 注册音量变化监听器
  void registerVolumeListener() {
    FlutterVolumeController.addListener((volume) {
      // 音量变化时的回调（Android 和 iOS）
      if (Platform.isAndroid || Platform.isIOS) {
        settings.volume.value = volume;
      }
    });
  }

  // volume & brightness
  Future<double?> volume() async {
    if (Platform.isWindows || Platform.isMacOS) {
      // Windows 和 macOS 使用播放器音量
      return mediaPlayerController.player.state.volume / 100;
    }
    // Android 和 iOS 使用系统音量
    return await FlutterVolumeController.getVolume();
  }

  Future<double> brightness() async {
    return await brightnessController.application;
  }

  void setVolume(double value) async {
    if (Platform.isWindows || Platform.isMacOS) {
      // Windows 和 macOS 使用播放器自己的音量控制
      try {
        mediaPlayerController.player.setVolume(value * 100);
      } catch (e) {
        log('设置音量失败: $e', name: 'video_controller');
      }
    } else {
      // Android 和 iOS 使用系统音量控制
      await FlutterVolumeController.setVolume(value);
    }
    settings.volume.value = value;
  }

  void setBrightness(double value) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await brightnessController.setApplicationScreenBrightness(value);
    }
  }
}

// use fullscreen with controller provider

class DesktopFullscreen extends StatelessWidget {
  const DesktopFullscreen({super.key, required this.controller});
  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.passthrough, // 使Stack填充整个父容器
          children: [
            Container(
              color: Colors.black, // 设置你想要的背景色
            ),
            Obx(
              () => media_kit_video.Video(
                key: ValueKey(controller.videoFit.value),
                pauseUponEnteringBackgroundMode: !controller.settings.enableBackgroundPlay.value,
                resumeUponEnteringForegroundMode: !controller.settings.enableBackgroundPlay.value,
                controller: controller.mediaPlayerController,
                fit: controller.videoFit.value,
                controls: controller.room.platform == Sites.iptvSite
                    ? media_kit_video.MaterialVideoControls
                    : (state) => VideoControllerPanel(controller: controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

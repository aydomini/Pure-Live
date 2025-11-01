import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:pure_live/common/index.dart';
import 'package:pure_live/plugins/global.dart';
import 'package:pure_live/routes/app_navigation.dart';
import 'package:pure_live/common/services/bilibili_account_service.dart';

const kWindowsScheme = 'purelive://signin';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefUtil.prefs = await SharedPreferences.getInstance();
  MediaKit.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS) {
    // 注释：WindowsSingleInstance 仅 Windows 支持，macOS/iOS 不需要
    // await WindowsSingleInstance.ensureSingleInstance(args, "pure_live_instance_checker");
    await windowManager.ensureInitialized();
    await WindowUtil.init(width: 1280, height: 720);
  }
  // 初始化服务
  initService();
  initRefresh();
  runApp(const MyApp());
}

void initService() {
  Get.put(SettingsService());
  Get.put(FavoriteController());
  Get.put(BiliBiliAccountService());
  Get.put(PopularController());
  Get.put(AreasController());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    // iOS 使用不带 WindowListener 的版本
    if (Platform.isIOS) {
      return _MyAppStateIOS();
    }
    // Windows/macOS 使用带 WindowListener 的版本
    return _MyAppStateDesktop();
  }
}

// iOS 版本（不使用 WindowListener）
class _MyAppStateIOS extends State<MyApp> {
  final settings = Get.find<SettingsService>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  String getName(String fullName) {
    return fullName.split(Platform.pathSeparator).last;
  }

  bool isDataSourceM3u(String url) => url.contains('.m3u');
  String getUUid() {
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var randomValue = Random().nextInt(4294967295);
    var result = (currentTime % 10000000000 * 1000 + randomValue) % 4294967295;
    return result.toString();
  }

  void _init() async {
    // iOS 不需要窗口初始化
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _buildApp();
  }

  Widget _buildApp() {
    return Shortcuts(
      shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()},
      child: Obx(() {
        if (settings.videoPlayerIndex.value > 1) {
          settings.videoPlayerIndex.value = 0;
        }

        var themeColor = HexColor(settings.themeColorSwitch.value);
        ThemeData lightTheme = MyTheme(primaryColor: themeColor).lightThemeData;
        ThemeData darkTheme = MyTheme(primaryColor: themeColor).darkThemeData;

        return GetMaterialApp(
          title: '纯粹直播',
          themeMode: SettingsService.themeModes[settings.themeModeName.value]!,
          theme: lightTheme.copyWith(appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent)),
          darkTheme: darkTheme.copyWith(appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent)),
          locale: SettingsService.languages[settings.languageName.value]!,
          navigatorObservers: [FlutterSmartDialog.observer, BackButtonObserver()],
          builder: FlutterSmartDialog.init(),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: RoutePath.kSplash,
          defaultTransition: Transition.native,
          getPages: AppPages.routes,
        );
      }),
    );
  }
}

// Desktop 版本（使用 WindowListener）
class _MyAppStateDesktop extends State<MyApp> with WindowListener {
  final settings = Get.find<SettingsService>();

  @override
  void initState() {
    super.initState();
    // 只在 Windows/macOS 上添加窗口监听器
    if (Platform.isWindows || Platform.isMacOS) {
      windowManager.addListener(this);
    }
    _init();
  }

  String getName(String fullName) {
    return fullName.split(Platform.pathSeparator).last;
  }

  bool isDataSourceM3u(String url) => url.contains('.m3u');
  String getUUid() {
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var randomValue = Random().nextInt(4294967295);
    var result = (currentTime % 10000000000 * 1000 + randomValue) % 4294967295;
    return result.toString();
  }

  @override
  void dispose() {
    // 只在 Windows/macOS 上移除窗口监听器
    if (Platform.isWindows || Platform.isMacOS) {
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  @override
  void onWindowFocus() {
    setState(() {});
    super.onWindowFocus();
  }

  @override
  void onWindowEvent(String eventName) {
    WindowUtil.setPosition();
  }

  void _init() async {
    if (Platform.isWindows || Platform.isMacOS) {
      await WindowUtil.setTitle();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()},
      child: Obx(() {
        if (Platform.isWindows) {
          settings.videoPlayerIndex.value = 0;
        } else {
          if (settings.videoPlayerIndex.value > 1) {
            settings.videoPlayerIndex.value = 0;
          }
        }

        var themeColor = HexColor(settings.themeColorSwitch.value);
        ThemeData lightTheme = MyTheme(primaryColor: themeColor).lightThemeData;
        ThemeData darkTheme = MyTheme(primaryColor: themeColor).darkThemeData;

        return GetMaterialApp(
          title: '纯粹直播',
          themeMode: SettingsService.themeModes[settings.themeModeName.value]!,
          theme: lightTheme.copyWith(appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent)),
          darkTheme: darkTheme.copyWith(appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent)),
          locale: SettingsService.languages[settings.languageName.value]!,
          navigatorObservers: [FlutterSmartDialog.observer, BackButtonObserver()],
          builder: FlutterSmartDialog.init(),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: RoutePath.kSplash,
          defaultTransition: Transition.native,
          getPages: AppPages.routes,
        );
      }),
    );
  }
}

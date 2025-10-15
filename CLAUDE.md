# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

纯粹直播是一个使用 Flutter 开发的第三方直播播放器应用，支持多个直播平台（哔哩哔哩、虎牙、斗鱼、快手、抖音、网易CC）以及 M3U8 自定义源。项目使用 GetX 进行状态管理，专注于 **macOS** 和 **iOS** 平台（已移除 Android、Windows、Linux 支持）。

## 开发环境要求

- Flutter SDK: ^3.8.1
- Dart SDK: ^3.8.1
- Xcode（macOS 开发必需）
- CocoaPods（依赖管理）

## 常用命令

### 开发调试
```bash
# 运行应用（开发模式）
flutter run

# 运行到特定设备
flutter run -d <device-id>

# 列出所有可用设备
flutter devices

# 热重载（在 flutter run 运行时按 r 键）
# 热重启（在 flutter run 运行时按 R 键）
```

### 构建命令

**iOS 构建：**
```bash
flutter build ios
```

**macOS 构建（重要）：**

由于代码签名问题，macOS 构建需要使用特殊方法：

**方法1：使用 Xcode 直接构建（推荐）**
```bash
# 1. 清理缓存
flutter clean

# 2. 获取依赖（使用中国镜像）
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get

# 3. 使用 Xcode 构建 Release 版本（禁用代码签名）
cd macos
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  build \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO
```

构建完成后，应用位于：
- `~/Library/Developer/Xcode/DerivedData/Runner-*/Build/Products/Release/pure_live.app`

**方法2：使用 Flutter 命令（可能失败）**
```bash
# 注意：可能因签名问题失败
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter build macos --release
```

**方法3：在 Xcode IDE 中构建（最稳定）**
```bash
open macos/Runner.xcworkspace
```
然后在 Xcode 中点击运行按钮（▶️）或 Product → Build (⌘B)

**关于代码签名：**
- 个人免费 Apple ID 签名后，`flutter build` 会失败，需要使用方法1或方法3
- 如需分发给他人，需加入 Apple Developer Program（¥688/年）
- Adhoc 签名的应用只能在本机运行，双击可能提示安全警告
- 绕过方法：右键应用 → 选择"打开" → 再次点击"打开"

**构建结果对比：**
- Debug 版本：~204MB（包含调试符号）
- Release 版本：~127MB（优化后，推荐使用）

### 代码生成和工具

```bash
# 运行代码生成器（用于生成 JSON 序列化代码和 Protobuf）
flutter pub run build_runner build

# 清理并重新生成
flutter pub run build_runner build --delete-conflicting-outputs

# 生成应用图标
flutter pub run flutter_launcher_icons

# 生成本地化文件
flutter pub run intl_utils:generate
```

### 测试和代码质量

```bash
# 代码分析
flutter analyze

# 格式化代码
flutter format lib/
```

### 依赖管理

```bash
# 获取依赖（中国镜像）
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get

# 更新依赖
flutter pub upgrade

# 清理构建缓存
flutter clean
```

## 核心架构

### 目录结构

```
lib/
├── common/              # 通用模块
│   ├── base/           # 基础类和接口
│   ├── l10n/           # 国际化文件
│   ├── models/         # 通用数据模型
│   ├── services/       # 全局服务（SettingsService, BiliBiliAccountService）
│   ├── style/          # 主题样式
│   ├── utils/          # 工具类
│   └── widgets/        # 通用UI组件
├── core/                # 核心业务逻辑
│   ├── common/         # 核心通用工具（HTTP客户端、User Agent等）
│   ├── danmaku/        # 弹幕实现（各平台WebSocket连接）
│   ├── interface/      # 核心接口定义
│   │   ├── live_site.dart      # 直播平台接口
│   │   └── live_danmaku.dart   # 弹幕接口
│   ├── iptv/           # IPTV/M3U8相关
│   ├── sign/           # 各平台签名算法
│   ├── site/           # 各平台具体实现
│   │   ├── bilibili_site.dart
│   │   ├── douyu_site.dart
│   │   ├── huya_site.dart
│   │   ├── douyin_site.dart
│   │   ├── kuaishou_site.dart
│   │   ├── cc_site.dart
│   │   └── iptv_site.dart
│   └── sites.dart      # 平台注册和管理
├── model/               # 数据模型
├── modules/             # 功能模块（页面）
│   ├── about/          # 关于页面
│   ├── account/        # 账户管理
│   ├── area_rooms/     # 分区房间列表
│   ├── areas/          # 分区管理
│   ├── auth/           # 认证（登录注册）
│   ├── backup/         # 备份还原
│   ├── favorite/       # 收藏管理
│   ├── history/        # 历史记录
│   ├── home/           # 首页
│   ├── live_play/      # 直播播放器
│   │   └── widgets/
│   │       ├── resizable_divider.dart        # 可调整大小的分隔条
│   │       └── video_player/                  # 视频播放器组件
│   ├── popular/        # 推荐页
│   ├── search/         # 搜索
│   ├── settings/       # 设置
│   ├── shield/         # 屏蔽词管理
│   ├── toolbox/        # 工具箱
│   └── web_dav/        # WebDAV同步
├── plugins/             # 插件和全局工具
├── routes/              # 路由配置
└── main.dart           # 应用入口
```

### 状态管理

项目使用**GetX**进行状态管理和依赖注入：

- **全局服务注入**：在`main.dart`的`initService()`中注入全局服务
  ```dart
  Get.put(SettingsService());
  Get.put(AuthController());
  Get.put(FavoriteController());
  Get.put(BiliBiliAccountService());
  ```

- **页面级控制器**：每个功能模块通常包含：
  - `xxx_page.dart` - UI页面
  - `xxx_controller.dart` - 业务逻辑控制器
  - `xxx_binding.dart` - 依赖绑定

- **使用模式**：
  ```dart
  // 获取服务
  final settings = Get.find<SettingsService>();

  // 响应式变量
  var count = 0.obs;  // 创建响应式变量
  Obx(() => Text('${count.value}'));  // UI自动更新
  ```

### 核心接口设计

**LiveSite接口** (`lib/core/interface/live_site.dart`)：
所有直播平台必须实现此接口，提供统一的API：
- `getCategores()` - 获取分类
- `searchRooms()` / `searchAnchors()` - 搜索
- `getCategoryRooms()` - 获取分区房间
- `getRecommendRooms()` - 获取推荐
- `getRoomDetail()` - 获取房间详情
- `getPlayQualites()` - 获取清晰度选项
- `getPlayUrls()` - 获取播放链接
- `getDanmaku()` - 获取弹幕连接实例

**LiveDanmaku接口** (`lib/core/interface/live_danmaku.dart`)：
弹幕WebSocket连接的统一接口：
- `start()` - 开始连接
- `stop()` - 停止连接
- `onMessage` / `onClose` / `onReady` - 事件回调

### 添加新平台支持

1. **创建平台实现类**：在`lib/core/site/`创建`xxx_site.dart`，继承`LiveSite`
2. **实现弹幕类**：在`lib/core/danmaku/`创建`xxx_danmaku.dart`，继承`LiveDanmaku`
3. **注册平台**：在`lib/core/sites.dart`的`supportSites`列表中添加
4. **添加平台图标**：在`assets/images/`添加平台logo

### 播放器架构

- **iOS/macOS**：使用 `media_kit`，支持多种视频格式和直播流
- 播放器配置在 `SettingsService` 中管理

### 本地化

- 本地化文件位于`lib/common/l10n/`
- 使用`intl`和`flutter_localizations`
- 支持的语言通过`SettingsService.languages`配置
- 修改ARB文件后运行`flutter pub run intl_utils:generate`生成代码

### 持久化存储

- **SharedPreferences**：通过`PrefUtil`封装，存储用户设置
- **Supabase**：用于用户认证和云端数据同步
- **WebDAV**：支持WebDAV协议进行配置同步

## 开发注意事项

### 平台兼容性

**macOS 特殊处理：**
- **依赖项**：需要 Xcode、CocoaPods、Flutter SDK
- **环境配置**：
  ```bash
  # 安装 Xcode Command Line Tools
  xcode-select --install

  # 安装 CocoaPods
  brew install cocoapods

  # 安装 Flutter
  brew install --cask flutter
  ```
- **代码签名问题**：
  - `flutter build macos` 可能因签名问题失败
  - 推荐使用 `xcodebuild` 命令构建（见"构建命令"部分）
  - 或在 Xcode IDE 中直接运行
- **AppIcon 配置**：
  - 图标位于 `macos/Runner/Assets.xcassets/AppIcon.appiconset/`
  - 包含 7 个尺寸：16, 32, 64, 128, 256, 512, 1024
  - 配置文件：`Contents.json`
- **中国网络环境**：
  - 使用镜像加速：`pub.flutter-io.cn`、`storage.flutter-io.cn`
  - 所有 `flutter` 命令前需设置环境变量
- **播放器**：使用 `media_kit` 的默认播放器
- **窗口管理**：使用 `window_manager` 包

**iOS 特殊处理：**
- 需要在 Xcode 中配置签名证书
- 真机调试需要有效的开发者账号
- 使用 `window_manager` 等桌面特定包在 iOS 上可能不可用

### 代码规范

- 使用`flutter_lints`进行静态分析
- 排除生成的文件：`**/*.g.dart`, `**/*_en.dart`, `**/*_zh_CN.dart`
- 导入顺序：
  1. Dart SDK库
  2. Flutter库
  3. 第三方包
  4. 项目内部文件

### Cookie和认证

- B站高清直播需要Cookie，通过第三方OAuth获取
- Cookie存储在`BiliBiliAccountService`中
- 支持通过Supabase进行用户账户管理（需要配置白名单）

### 签名和加密

某些平台需要特殊的签名算法：
- **斗鱼**：`lib/core/sign/douyu.dart` - `getSign()`
- **抖音**：`lib/core/sign/douyin.dart` - `getAbogusUrl()`, `getSignature()`
- 这些函数通过函数注入方式设置到对应的Site实例中

### M3U8 自定义源

- 支持导入网络/本地 M3U8 文件
- iOS 端通过文件分享功能导入
- macOS 端可通过文件选择器导入

### 弹幕显示区域

弹幕显示区域支持3种模式，可在设置或播放器控制面板中调节：

**配置位置**：`lib/common/services/settings_service.dart:360-364`
```dart
static const List<Map<String, dynamic>> danmakuAreaModes = [
  {'mode': 0, 'name': '全屏', 'topArea': 0.0, 'bottomArea': 0.0},     // 100%显示区域
  {'mode': 1, 'name': '2/3屏', 'topArea': 0.0, 'bottomArea': 0.33},   // 67%显示区域（上方2/3）
  {'mode': 2, 'name': '1/3屏', 'topArea': 0.0, 'bottomArea': 0.67},   // 33%显示区域（上方1/3）
];
```

**实现逻辑**：
- `topArea` 和 `bottomArea` 表示屏幕顶部和底部预留的**空白区域比例**
- 弹幕实际显示区域 = 屏幕高度 × (1 - topArea - bottomArea)
- 弹幕轨道数 = floor(弹幕显示区域高度 / 单行弹幕高度)

**UI组件**：
- 设置页面：`lib/modules/settings/danmuset.dart` - 使用 `ChoiceChip` 选择
- 播放器控制面板：`lib/modules/live_play/widgets/video_player/video_controller_panel.dart` - 实时切换
- 弹幕渲染：`lib/pkg/canvas_danmaku/danmaku_screen.dart` - 计算显示区域

## 依赖说明

**关键依赖：**
- `get` - 状态管理和路由
- `media_kit` - 视频播放器
- `supabase_flutter` - 后端服务和认证
- `flutter_smart_dialog` - 弹窗和 Toast
- `cached_network_image` - 图片缓存
- `web_socket_channel` - WebSocket 连接（弹幕）
- `window_manager` - macOS 窗口管理
- `webdav_client` - WebDAV 同步
- `dio` - HTTP 客户端
- `shared_preferences` - 本地存储
- `qr_flutter` + `mobile_scanner` - 二维码功能

## 常见问题

### macOS 构建和运行问题

**问题1：flutter build macos 失败，提示签名错误**
```
Error: resource fork, Finder information, or similar detritus not allowed
Error: code signature not valid for use in process
```
**解决方案：**
使用 Xcode 直接构建：
```bash
cd macos
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  build \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO
```

**问题2：flutter pub get 超时**
**解决方案：**
使用中国镜像：
```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get
```

**问题3：双击应用提示"无法打开"或"已损坏"**
**解决方案：**
- 方法1：右键点击应用 → 选择"打开" → 再次点击"打开"
- 方法2：在 Xcode 中直接运行（最可靠）
- 方法3：复制到 `/Applications/` 文件夹后再打开

**问题4：Xcode 显示 985 个 issues（警告）**
**说明：**
这些是第三方库的警告，不影响构建。BUILD SUCCEEDED 表示构建成功。

**问题5：CocoaPods 安装失败，提示需要 sudo**
**解决方案：**
使用 Homebrew 安装（无需 sudo）：
```bash
brew install cocoapods
```

**问题6：找不到 Flutter 或 Xcode**
**解决方案：**
```bash
# 检查 Flutter
which flutter
flutter doctor

# 检查 Xcode
xcode-select -p

# 如果未安装，使用 Homebrew
brew install --cask flutter
```

### iOS 常见问题

**问题1：真机调试失败**
**解决方案：**
- 在 Xcode 中配置有效的开发者证书
- 确保设备已信任开发者证书
- 检查 Bundle Identifier 是否正确

**问题2：应用安装后无法打开**
**解决方案：**
- 在设备的"设置 → 通用 → VPN与设备管理"中信任开发者

### 导航和路由问题

**问题1：点击搜索页返回按钮后应用黑屏**
**原因分析：**
- SearchPage 是主页的第4个Tab，通过侧边栏按钮切换显示（非路由跳转）
- 返回按钮错误使用了 `Navigator.of(Get.context!).pop()`
- 由于搜索页不是通过路由push的，`pop()` 会错误地弹出整个主页
- 主页设置了 `canPop: false`，强制pop后导航栈为空，导致黑屏

**解决方案：**
修改 `lib/modules/search/search_page.dart:25-27`：
```dart
// 错误做法 ❌
prefixIcon: IconButton(
  onPressed: () {
    Navigator.of(Get.context!).pop();  // 会弹出整个主页
  },
  icon: const Icon(Icons.arrow_back),
),

// 正确做法 ✅
prefixIcon: IconButton(
  onPressed: () {
    // 切换回收藏页（第一个Tab）
    Get.find<FavoriteController>().tabBottomIndex.value = 0;
  },
  icon: const Icon(Icons.arrow_back),
),
```

**要点**：
- Tab式导航应使用 `FavoriteController.tabBottomIndex` 控制切换
- 只有通过路由跳转的页面才使用 `Navigator.pop()` 或 `Get.back()`
- 主页的Tab切换监听在 `home_page.dart:43-45` 实现

## 调试技巧

- 使用 `logger` 包进行日志记录
- 使用 Flutter DevTools 进行性能分析
- iOS/macOS 可使用 Xcode 的 Console 查看日志

## 项目结构

```
pure_live/
├── lib/                 # 源代码
├── assets/              # 资源文件
├── macos/               # macOS 平台代码
├── ios/                 # iOS 平台代码
├── pubspec.yaml         # 项目配置
├── build.yaml           # Protobuf 生成配置
├── analysis_options.yaml # 代码分析规则
├── README.md            # 项目说明
├── CLAUDE.md            # 开发指南（本文件）
└── LICENSE              # 开源许可证
```

## 技术栈总结

- **框架**：Flutter 3.8.1+
- **语言**：Dart 3.8.1+
- **状态管理**：GetX
- **UI 组件**：Material Design + 自定义组件
- **网络**：dio + web_socket_channel
- **视频播放**：media_kit
- **本地存储**：shared_preferences
- **云端服务**：supabase_flutter
- **国际化**：intl + flutter_localizations
- **代码生成**：build_runner + json_serializable + protoc_builder

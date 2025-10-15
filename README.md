<h1 align="center">
  <br>
  <img src="https://github.com/liuchuancong/pure_live/blob/master/assets/icons/icon.png" width="150"/>
  <br>
  纯粹直播
  <br>
</h1>
<h4 align="center">第三方直播播放器（macOS / iOS 专版）</h4>
<h4 align="center">A Third-party Live Stream Player for macOS and iOS</h4>
<p align="center">
	<img alt="Using GPL-v3" src="https://img.shields.io/badge/license-GPL--v3-blue">
	<img alt="Version" src="https://img.shields.io/badge/version-2.0.0-brightgreen">
	<img alt="Platform" src="https://img.shields.io/badge/platform-macOS%20%7C%20iOS-lightgrey">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.8.1+-blue">
  <h4 align="center">本软件仅供学习交流使用  请勿用于其他用途</h4>
	<h4 align="center">下载后请在24小时内删除</h4>
</p>

## 📖 简介

纯粹直播是一款专为 **macOS** 和 **iOS** 平台打造的第三方直播播放器，支持多个主流直播平台的视频流播放。本项目已移除 Android、Windows、Linux 支持，专注于优化 Apple 生态体验。

### 支持平台

***哔哩哔哩*** / ***虎牙*** / ***斗鱼*** / ***快手*** / ***抖音*** / ***网易CC*** / ***M3U8 自定义源***

可以选择喜爱的分区展示，或者全隐藏，只看关注，节省流量与内存

## ✨ 核心功能

### 📺 播放功能
- [X] **多平台支持** 哔哩哔哩、虎牙、斗鱼、快手、抖音、网易CC
- [X] **M3U8 自定义源** 支持导入网络/本地直播源，观看自定义内容
- [X] **高清播放** 支持多种清晰度切换（需对应平台账号权限）
- [X] **后台播放** 支持后台音频播放（可选）
- [X] **可调整布局** 可调整大小的播放器分隔条，自由调整观看区域

### 💬 弹幕功能
- [X] **弹幕显示** 实时显示各平台弹幕
- [X] **弹幕过滤** 自定义关键词过滤
- [X] **弹幕合并** 合并重复弹幕，减少干扰
- [X] **弹幕区域调节** 支持全屏 / 2/3屏 / 1/3屏三种显示模式
- [X] **弹幕样式调整** 自定义透明度、速度、字体大小、描边

### 🔧 管理功能
- [X] **平台管理** 自定义显示/隐藏平台，只看关注的内容
- [X] **收藏管理** 关注喜爱的主播，快速访问
- [X] **历史记录** 自动记录观看历史
- [X] **WebDAV 同步** 云端同步配置和收藏数据
- [X] **定时关闭** 倒计时自动关闭应用

### 🎨 界面功能
- [X] **主题切换** 支持浅色/深色/跟随系统
- [X] **动态主题** 自定义主题颜色
- [X] **多语言** 支持中文/英文
- [X] **全屏模式** 沉浸式观看体验

## 💻 系统要求

### macOS
- **最低版本**: macOS 10.13 (High Sierra)
- **推荐版本**: macOS 11.0 (Big Sur) 或更高
- **处理器**: Intel 或 Apple Silicon (M1/M2/M3)
- **运行内存**: 建议 4GB 以上

### iOS
- **最低版本**: iOS 12.0
- **设备支持**: iPhone 和 iPad
- **运行内存**: 建议 2GB 以上

## 🛠️ 技术栈

### 核心框架
- **Flutter SDK**: ^3.8.1
- **Dart SDK**: ^3.8.1
- **状态管理**: GetX (^5.0.0)

### 主要依赖
| 功能模块 | 依赖库 | 说明 |
|---------|--------|------|
| 视频播放 | `media_kit` (^1.2.0) | 基于 libmpv 的高性能播放器 |
| 网络请求 | `dio` (^5.3.3) | HTTP 客户端 |
| 本地存储 | `shared_preferences` (^2.2.2) | 键值对存储 |
| 云端同步 | `webdav_client` (^1.2.2) | WebDAV 协议支持 |
| 弹幕渲染 | 自定义 `canvas_danmaku` | Canvas 绘制弹幕 |
| WebSocket | `web_socket_channel` (^3.0.1) | 实时弹幕连接 |
| 窗口管理 | `window_manager` (^0.5.0) | macOS 窗口控制 |
| 二维码 | `qr_flutter` + `mobile_scanner` | B站登录 |
| 图片缓存 | `cached_network_image` (^3.3.0) | 网络图片缓存 |

### 平台特性
- **macOS**: 原生窗口管理、系统级音量控制、软件渲染优化
- **iOS**: 移动端手势、屏幕亮度控制、电量显示

## 📂 项目结构

```
lib/
├── common/              # 通用模块
│   ├── base/           # 基础类和接口
│   ├── l10n/           # 国际化文件（中文/英文）
│   ├── models/         # 通用数据模型
│   ├── services/       # 全局服务（设置、账户、收藏等）
│   ├── style/          # 主题样式
│   ├── utils/          # 工具类（HTTP、缓存、日志等）
│   └── widgets/        # 通用 UI 组件
├── core/                # 核心业务逻辑
│   ├── common/         # HTTP 客户端、User Agent 等
│   ├── danmaku/        # 各平台弹幕 WebSocket 实现
│   ├── interface/      # 核心接口定义（LiveSite、LiveDanmaku）
│   ├── iptv/           # IPTV/M3U8 解析
│   ├── sign/           # 各平台签名算法（斗鱼、抖音）
│   ├── site/           # 各平台具体实现
│   │   ├── bilibili_site.dart
│   │   ├── douyu_site.dart
│   │   ├── huya_site.dart
│   │   ├── douyin_site.dart
│   │   ├── kuaishou_site.dart
│   │   ├── cc_site.dart
│   │   └── iptv_site.dart
│   └── sites.dart      # 平台注册和管理
├── modules/             # 功能模块（页面）
│   ├── about/          # 关于页面
│   ├── account/        # 账户管理（B站登录、虎牙Cookie）
│   ├── area_rooms/     # 分区房间列表
│   ├── areas/          # 分区管理
│   ├── backup/         # 备份还原
│   ├── favorite/       # 收藏管理
│   ├── history/        # 历史记录
│   ├── home/           # 首页（底部导航）
│   ├── live_play/      # 直播播放器
│   │   └── widgets/
│   │       ├── resizable_divider.dart    # 可调整分隔条
│   │       └── video_player/              # 播放器组件
│   ├── popular/        # 推荐页
│   ├── search/         # 搜索
│   ├── settings/       # 设置
│   ├── shield/         # 屏蔽词管理
│   ├── toolbox/        # 工具箱
│   └── web_dav/        # WebDAV 同步
├── pkg/                 # 自定义包
│   └── canvas_danmaku/ # 弹幕渲染引擎
├── plugins/             # 插件和全局工具
├── routes/              # 路由配置
└── main.dart           # 应用入口
```

## 🔨 构建说明

<details>
<summary><b>展开查看构建步骤</b></summary>

### 环境准备

1. **安装 Flutter SDK**
   ```bash
   # 使用 Homebrew（推荐）
   brew install --cask flutter

   # 或从官网下载：https://flutter.dev
   ```

2. **安装 Xcode**
   - 从 Mac App Store 安装 Xcode
   - 安装 Command Line Tools：
     ```bash
     xcode-select --install
     ```

3. **安装 CocoaPods**
   ```bash
   brew install cocoapods
   ```

4. **验证环境**
   ```bash
   flutter doctor
   ```

### 快速构建

#### macOS 应用

**⚠️ 重要提示：必须使用 Flutter 命令构建，不能直接用 Xcode！**

由于 Frameworks 签名问题，必须按照以下步骤构建：

**方法1：一键构建脚本（推荐）**
```bash
# 自动完成：清理 → 依赖 → 构建 → 打包 DMG（含签名）
bash scripts/build_and_release.sh

# 输出：build/macos/PureLive-macOS-{VERSION}.dmg
```

**方法2：分步执行**
```bash
# 1. 设置中国镜像（可选，加速下载）
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# 2. 清理和获取依赖
flutter clean
flutter pub get

# 3. 构建 Release 版本（必须用 flutter 命令）
flutter build macos --release

# 4. 打包 DMG（自动对 Frameworks 签名）
bash scripts/create_dmg_native.sh

# 应用位于：build/macos/Build/Products/Release/Pure-Live.app
# DMG 位于：build/macos/PureLive-macOS-{VERSION}.dmg
```

**⚠️ 不推荐：使用 Xcode IDE 构建**
```bash
# 仅用于开发调试，不用于发布
open macos/Runner.xcworkspace
```
注意：Xcode 直接构建的应用可能因签名问题无法打开，发布版本必须使用方法1或方法2。

#### iOS 应用

```bash
# 构建 iOS 应用
flutter build ios --release

# 需要在 Xcode 中配置签名证书
open ios/Runner.xcworkspace
```

### DMG 打包（仅 macOS）

**重要：打包脚本会自动对所有 Frameworks 进行签名**

```bash
# 前提：已完成 flutter build macos --release
bash scripts/create_dmg_native.sh

# 输出：build/macos/PureLive-macOS-{VERSION}.dmg (~59MB)

# 脚本自动执行：
# 1. 清除扩展属性
# 2. 对所有 Frameworks 进行 adhoc 签名
# 3. 对整个应用进行 adhoc 签名
# 4. 创建压缩 DMG
```

**验证 DMG：**
```bash
# 验证完整性
hdiutil verify build/macos/PureLive-macOS-{VERSION}.dmg

# 测试应用能否打开
hdiutil attach build/macos/PureLive-macOS-{VERSION}.dmg
open /Volumes/Pure\ Live/Pure-Live.app
```

</details>

## 📖 使用说明

### 关于播放器

本软件使用 [media_kit](https://pub.dev/packages/media_kit) 作为播放器，基于 libmpv 实现，支持多种视频格式和直播流协议。

**键盘快捷键（macOS）:**
- `Space` - 播放/暂停
- `↑/↓` - 音量调节（+5% / -5%）
- `ESC` - 退出全屏
- `R` - 刷新播放

### 关于 Cookie

由于平台限制，观看 B 站高清直播需要登录。本软件提供第三方 OAuth 认证获取 **Cookie**，不会获取用户的任何敏感信息，用户数据仍由第三方平台管理。

**B站登录步骤：**
1. 设置 → 账户管理 → B站账号登录
2. 使用哔哩哔哩 App 扫描二维码
3. 授权后即可观看高清直播

### 关于 M3U8 自定义源

支持导入网络/本地 M3U8 直播源（电视直播、电影轮播等）。

**导入方法：**
1. 设置 → 备份与还原 → 导入 M3U8 源
2. 选择网络 URL 或本地文件
3. iOS 端可通过系统"共享"功能直接打开 M3U8 文件

**资源推荐：**
- [直播源转换工具](https://guihet.com/tvlistconvert.html)
- [IPTV 源收集](https://github.com/topics/iptv)

### 关于 WebDAV 同步

支持通过 WebDAV 协议同步配置和收藏数据到云端。

**支持的服务：**
- 坚果云（推荐）
- Nextcloud
- ownCloud
- Synology NAS
- 其他支持 WebDAV 的服务

## ❓ 常见问题

<details>
<summary><b>展开查看常见问题</b></summary>

### 使用问题

<details>
<summary><b>Q: 播放卡顿或无法播放？</b></summary>

**A**:
1. 检查网络连接是否正常
2. 尝试切换清晰度或线路
3. 点击"刷新"按钮重新加载
4. macOS 用户可尝试在设置中调整播放器参数
</details>

<details>
<summary><b>Q: 弹幕不显示？</b></summary>

**A**:
1. 检查设置 → 弹幕设置 → 确认"弹幕开关"已开启
2. 确认主播直播间有弹幕活动
3. 尝试刷新播放器
</details>

<details>
<summary><b>Q: 无法登录 B站账号？</b></summary>

**A**:
1. 确保哔哩哔哩 App 已登录
2. 使用最新版哔哩哔哩 App 扫描二维码
3. 检查网络连接，确保可以访问 B站服务器
</details>

<details>
<summary><b>Q: macOS 应用提示"已损坏"？</b></summary>

**A**: 由于应用未经 Apple 公证，首次打开需要：
1. 右键点击应用 → 选择"打开"
2. 在弹出的对话框中再次点击"打开"
3. 或在系统设置 → 隐私与安全性中允许应用运行
</details>

### 构建问题

<details>
<summary><b>Q: macOS 应用无法打开，提示 Frameworks 签名错误？</b></summary>

**A**: 这是因为打包时未对 Frameworks 签名。必须使用项目提供的打包脚本：
```bash
# 正确的构建流程
flutter clean
flutter pub get
flutter build macos --release
bash scripts/create_dmg_native.sh

# 脚本会自动对所有 Frameworks 进行 adhoc 签名
# 不要直接用 Xcode 构建用于发布！
```
</details>

<details>
<summary><b>Q: macOS 构建失败，提示签名错误？</b></summary>

**A**: 不要使用 `xcodebuild` 直接构建，使用 Flutter 命令：
```bash
flutter build macos --release
```
然后使用打包脚本创建 DMG（自动处理签名）。
</details>

<details>
<summary><b>Q: flutter pub get 超时？</b></summary>

**A**: 使用中国镜像：
```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get
```
</details>

<details>
<summary><b>Q: 双击应用提示"无法打开"或"已损坏"？</b></summary>

**A**:
1. 右键点击应用 → 选择"打开" → 再次点击"打开"
2. 或复制到 `/Applications/` 文件夹后再打开
</details>

<details>
<summary><b>Q: iOS 真机调试失败？</b></summary>

**A**:
1. 在 Xcode 中配置有效的开发者证书
2. 在设备的"设置 → 通用 → VPN与设备管理"中信任开发者
</details>

</details>

## 📜 声明

本软件为**非盈利性开源项目**，遵循 [**GPL-v3**](LICENSE) 协议，请勿将此软件用于商业用途。

- 本软件**不提供** VIP 视频破解等服务
- 如需高清播放，需在对应平台取得相应权限
- 所有内容资源版权归各平台所有
- 本软件仅供学习交流使用，如有侵权请发 Issue 提出

## 🔒 隐私策略

- ✅ 开源项目，代码完全透明
- ✅ 无广告、无病毒、无后门
- ✅ 不收集用户个人信息
- ✅ Cookie 仅用于平台认证，存储在本地
- ✅ 支持 WebDAV 自托管云端同步

## 📦 源码仓库

本项目在以下源码仓库基础上进行构建和维护（按时间顺序）：

1. **一级源码仓库（原始项目）**
   [ice_live_viewer](https://github.com/Xmarmalade/ice_live_viewer)
   最初的项目雏形，提供了基础架构和设计理念

2. **二级源码仓库（多平台扩展）**
   [pure_live](https://github.com/Jackiu1997/pure_live)
   扩展了多平台支持，增加了弹幕功能和界面优化

3. **三级源码仓库（当前维护版本）**
   [pure_live](https://github.com/liuchuancong/pure_live)
   当前活跃维护版本，持续更新功能和修复问题

本仓库基于三级仓库，专注于 **macOS** 和 **iOS** 平台的优化和改进。

## 📝 许可证

本项目采用 [GPL-v3](LICENSE) 开源协议。

---

<p align="center">
基于 <a href="https://flutter.dev">Flutter</a> 构建 | 遵循 <a href="LICENSE">GPL-v3</a> 开源协议
</p>

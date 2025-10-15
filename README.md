
<h1 align="center">
  <br>
  <img src="https://github.com/liuchuancong/pure_live/blob/master/assets/icons/icon.png" width="150"/>
  <br>
  纯粹直播
  <br>
</h1>
<h4 align="center">第三方直播播放器（macOS / iOS 版本）</h4>
<h4 align="center">A Third-party Live Stream Player for macOS and iOS</h4>
<p align="center">
	<img alt="Using GPL-v3" src="https://img.shields.io/github/license/liuchuancong/pure_live">
	<img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/liuchuancong/pure_live">
  <img alt="GitHub Star" src="https://img.shields.io/github/stars/liuchuancong/pure_live">
  <h4 align="center">本软件仅供学习交流使用  请勿用于其他用途</h4>
	<h4 align="center">下载后请在24小时内删除</h4>
</p>

## 支持平台

本项目专注于 **macOS** 和 **iOS** 平台，已移除 Android、Windows、Linux 支持以简化维护。

***哔哩哔哩***/***虎牙***/***斗鱼***/***快手***/***抖音***/***网易cc***/***M3U8自定义源***

可以选择喜爱的分区展示，或者全隐藏，只看关注，节省流量与内存

## 功能

- [X] 使用 [supabase](https://supabase.com/) 完成登录注册功能，邮箱为真实邮箱 ***白名单使用（发送注册账号到我的邮箱认证 - 点击联系）*** 您可自己 fork 项目去 supabase 控制台生成远程服务，具体不在赘述，只提供表字段。
- [X] **平台管理** 多种平台选择喜欢的展示
- [X] 已实现 **macOS** / **iOS** 平台
- [X] 已实现 **WebDav** 云端同步
- [X] 已实现倒计时关闭应用
- [X] **M3U8** 自定义导入网络/本地直播源，可直接使用 APP 打开，观看自定义内容
- [X] 弹幕过滤、弹幕合并
- [X] 弹幕显示区域可调节（全屏 / 2/3屏 / 1/3屏）
- [X] 可调整大小的播放器布局分隔条

## 系统要求

### macOS
- macOS 10.13 或更高版本
- 需要 Xcode Command Line Tools
- 建议使用 macOS 11.0 或更高版本以获得最佳体验

### iOS
- iOS 12.0 或更高版本
- 支持 iPhone 和 iPad

## 构建说明

### 环境准备

1. 安装 Flutter SDK (≥3.8.1)
2. 安装 Xcode（从 Mac App Store）
3. 安装 CocoaPods：
   ```bash
   brew install cocoapods
   ```

### 构建步骤

**获取依赖：**
```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get
```

**macOS 构建（推荐方法）：**
```bash
# 方法1：使用 Xcode 命令行构建
cd macos
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  build \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO

# 应用位于：~/Library/Developer/Xcode/DerivedData/Runner-*/Build/Products/Release/pure_live.app
```

**方法2：使用 Xcode IDE 构建（最稳定）**
```bash
open macos/Runner.xcworkspace
```
然后在 Xcode 中点击运行按钮（▶️）或 Product → Build (⌘B)

**iOS 构建：**
```bash
flutter build ios
```
需要在 Xcode 中配置签名证书才能在真机上运行。

## 声明

本软件非盈利性软件，且遵循 [**GPL-v3**](LICENSE) 协议，请勿将此软件用于商业用途。

本软件**不提供** VIP 视频破解等服务，如需高清播放，你需要在对应平台取得相应身份才能进行播放。

所有内容资源（包括但不限于音源、视频、图片等）版权归各平台所有。

本软件仅学习交流使用。如有侵权，请发 Issue 提出。

## 隐私策略

本 App 为开源项目，无广告，无病毒。

## 相关说明

### 关于播放器

本软件使用 [media_kit](https://pub.dev/packages/media_kit) 作为播放器，支持多种视频格式和直播流。

### Cookie

由于第三方限制，观看 B 站高清直播需要登录，您可点击三方认证即可获取 cookie，本软件只是代理获取拿到 **cookie**，不会获取用户的任何信息，用户信息仍由第三方管理。

### M3U8 源

您可点击设置-备份与还原-导入 M3U8 源（一些网络电视、电影轮播等）。[直播源转换](https://guihet.com/tvlistconvert.html)

### 常见问题

**Q: macOS 构建失败，提示签名错误？**

A: 使用 Xcode 命令行构建，并禁用代码签名（见上方构建步骤）

**Q: 双击应用提示"无法打开"或"已损坏"？**

A: 右键点击应用 → 选择"打开" → 再次点击"打开"

**Q: iOS 安装失败？**

A: 需要在 Xcode 中配置有效的开发者证书和描述文件

**Q: 点击搜索页返回按钮后应用黑屏？**

A: 已在最新版本中修复，搜索页返回按钮现在会正确切换回收藏页

## 开发

详细的开发文档请参考 [CLAUDE.md](CLAUDE.md)

### 技术栈
- Flutter SDK: ^3.8.1
- Dart SDK: ^3.8.1
- 状态管理：GetX
- 视频播放：media_kit
- 网络请求：dio
- 本地存储：shared_preferences
- 云端服务：supabase_flutter

## 意见

> 如有许可协议使用不当请发 Issue 或者 Pull Request
>
> If any of the licenses are not being used correctly, please submit a new issue.

## 代码参考

* dart_simple_live [dart_simple_live](https://github.com/xiaoyaocz/dart_simple_live)
* pure_live [pure_live](https://github.com/Jackiu1997/pure_live)

## Supabase 表结构

由于是开源项目，目前很多配置文件暴露在外，导致大量机器循环调用，消耗内存以及流量。

警告：在创建项目时请结合 [https://zuplo.com/](https://zuplo.com/) 使用，权限表添加允许创建的账户修改数据库。

配置在 assets 文件中打包的时候依然可以通过逆向解压可以查看该配置，最好写成 dart 代码引入，上传时忽略。

![image](https://github.com/liuchuancong/pure_live/assets/36957912/4e4fefb8-20bb-4a1f-a224-f581de3d95ec)

## 开发者

* 主开发者: [liuchuancong](https://github.com/liuchuancong)

[![Stargazers over time](https://starchart.cc/liuchuancong/pure_live.svg)](https://starchart.cc/liuchuancong/pure_live)

## 捐助

<img alt="wechat" width="250" src="https://github.com/liuchuancong/pure_live/blob/master/assets/images/wechat.png">

感谢您的支持！

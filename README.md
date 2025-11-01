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
	<img alt="Version" src="https://img.shields.io/badge/version-2.1.0-brightgreen">
	<img alt="Platform" src="https://img.shields.io/badge/platform-macOS%20%7C%20iOS-lightgrey">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.8.1+-blue">
  <h4 align="center">本软件仅供学习交流使用  请勿用于其他用途</h4>
	<h4 align="center">下载后请在24小时内删除</h4>
</p>

> [English](README_EN.md) | 简体中文

## 📖 简介

纯粹直播是一款专为 **macOS** 和 **iOS** 平台打造的第三方直播播放器，支持多个主流直播平台的视频流播放。本项目已移除 Android、Windows、Linux 支持，专注于优化 Apple 生态体验。

### 支持平台

***哔哩哔哩*** / ***虎牙*** / ***斗鱼*** / ***快手*** / ***抖音*** / ***网易CC***

可以选择喜爱的分区展示，或者全隐藏，只看关注，节省流量与内存

## ✨ 核心功能

### 📺 播放功能
- [X] **多平台支持** 哔哩哔哩、虎牙、斗鱼、快手、抖音、网易CC
- [X] **高清播放** 支持多种清晰度切换（需对应平台账号权限）
- [X] **后台播放** 支持后台音频播放（可选）
- [X] **可调整布局** 可调整大小的播放器分隔条，自由调整观看区域
- [X] **智能全屏** 手动/自动全屏模式，优化旋转体验（v2.1.0）

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
- **最低版本**: macOS 10.15 (Catalina)
- **推荐版本**: macOS 11.0 (Big Sur) 或更高
- **处理器**: Intel 或 Apple Silicon (M1/M2/M3/M4)
- **运行内存**: 建议 4GB 以上

### iOS
- **最低版本**: iOS 13.0
- **设备支持**: iPhone 和 iPad
- **运行内存**: 建议 2GB 以上

## 📦 下载安装

### macOS
1. 下载 `PureLive-macOS-{VERSION}.dmg`
2. 双击挂载 DMG
3. 将应用拖到 `Applications` 文件夹
4. **首次运行**：右键点击 → 选择"打开" → 再次点击"打开"（绕过安全检查）

**注意**：应用使用 adhoc 签名未经 Apple 公证，首次打开需右键选择"打开"

### iOS（开发测试版）
- 需通过 Xcode 或 Apple Configurator 安装 IPA
- Development IPA 有效期 7 天，仅供测试
- 如需长期使用建议加入 Apple Developer Program

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
- **macOS**: 原生窗口管理、系统级音量控制、media_kit 播放器
- **iOS**: 移动端手势、屏幕亮度控制、电量显示、media_kit 播放器

## 📂 仓库结构

**本仓库仅包含源代码文件：**

```
Pure-Live/               # 纯源代码仓库
├── lib/                 # Flutter 应用源代码 ✅
│   ├── common/          # 基础服务与通用组件
│   ├── core/            # 平台协议与核心业务
│   ├── model/           # 数据模型
│   ├── modules/         # 功能模块（页面）
│   ├── pkg/             # 自定义包
│   ├── plugins/         # 插件和工具
│   ├── routes/          # 路由配置
│   └── main.dart        # 应用入口
├── ios/                 # iOS 平台代码 ✅
│   ├── Runner/          # 应用配置
│   └── Runner.xcodeproj # Xcode 项目文件
├── macos/               # macOS 平台代码 ✅
│   ├── Runner/          # 应用配置
│   └── Runner.xcodeproj # Xcode 项目文件
├── scripts/             # 构建和发布脚本 ✅
│   ├── build_and_release.sh
│   └── create_dmg_native.sh
├── README.md            # 项目说明 ✅
├── README_EN.md         # English README ✅
└── LICENSE              # 开源许可证 ✅
```

**⚠️ 未包含在仓库中的文件：**
```
❌ assets/               # 资源文件（表情包、图片、字体）
❌ pubspec.yaml          # 依赖配置
❌ analysis_options.yaml # 代码分析规则
❌ build.yaml            # 构建配置
```

**如需运行项目：**
1. 需要自行配置 `pubspec.yaml` 并安装依赖
2. 资源文件需要从完整版仓库获取
3. 详细依赖列表请查看技术栈章节

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
<summary><b>Q: 播放卡顿或无法播放？</b></summary>

**A**:
1. 检查网络连接是否正常
2. 尝试切换清晰度或线路
3. 点击"刷新"按钮重新加载
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
基于 <a href="https://flutter.dev">Flutter</a> 构建
</p>

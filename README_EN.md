<h1 align="center">
  <br>
  <img src="https://github.com/liuchuancong/pure_live/blob/master/assets/icons/icon.png" width="150"/>
  <br>
  Pure Live
  <br>
</h1>
<h4 align="center">Third-party Live Stream Player for macOS and iOS</h4>
<p align="center">
	<img alt="Using GPL-v3" src="https://img.shields.io/badge/license-GPL--v3-blue">
	<img alt="Version" src="https://img.shields.io/badge/version-2.1.0-brightgreen">
	<img alt="Platform" src="https://img.shields.io/badge/platform-macOS%20%7C%20iOS-lightgrey">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.8.1+-blue">
  <h4 align="center">For educational and learning purposes only</h4>
	<h4 align="center">Please delete within 24 hours after download</h4>
</p>

> English | [简体中文](README.md)

## 📖 Introduction

Pure Live is a third-party live streaming player specifically designed for **macOS** and **iOS** platforms, supporting video streams from multiple mainstream live streaming platforms. This project has removed support for Android, Windows, and Linux to focus on optimizing the Apple ecosystem experience.

### Supported Platforms

***Bilibili*** / ***Huya*** / ***Douyu*** / ***Kuaishou*** / ***Douyin*** / ***CC***

Customize which platforms to display, or hide them all and only watch your favorites to save bandwidth and memory.

## ✨ Core Features

### 📺 Playback Features
- [X] **Multi-platform Support** Bilibili, Huya, Douyu, Kuaishou, Douyin, CC
- [X] **HD Playback** Support multiple quality options (requires platform account permissions)
- [X] **Background Playback** Optional background audio playback
- [X] **Adjustable Layout** Resizable player divider for flexible viewing area
- [X] **Smart Fullscreen** Manual/Auto fullscreen modes with optimized rotation experience (v2.1.0)

### 💬 Danmaku Features
- [X] **Danmaku Display** Real-time display of platform comments
- [X] **Danmaku Filtering** Custom keyword filtering
- [X] **Danmaku Merging** Merge duplicate comments to reduce clutter
- [X] **Display Area Adjustment** Support fullscreen / 2/3 screen / 1/3 screen modes
- [X] **Style Customization** Adjust opacity, speed, font size, stroke width

### 🔧 Management Features
- [X] **Platform Management** Customize platform visibility
- [X] **Favorites Management** Follow your favorite streamers for quick access
- [X] **Watch History** Automatically record viewing history
- [X] **WebDAV Sync** Cloud sync for configurations and favorites
- [X] **Auto Shutdown** Countdown timer to close application

### 🎨 Interface Features
- [X] **Theme Switching** Support light/dark/system theme
- [X] **Dynamic Theme** Custom theme colors
- [X] **Multi-language** Support Chinese/English
- [X] **Fullscreen Mode** Immersive viewing experience

## 💻 System Requirements

### macOS
- **Minimum**: macOS 10.15 (Catalina)
- **Recommended**: macOS 11.0 (Big Sur) or later
- **Processor**: Intel or Apple Silicon (M1/M2/M3/M4)
- **RAM**: 4GB or more recommended

### iOS
- **Minimum**: iOS 13.0
- **Devices**: iPhone and iPad
- **RAM**: 2GB or more recommended

## 📦 Download & Installation

### macOS
1. Download `PureLive-macOS-{VERSION}.dmg`
2. Double-click to mount the DMG
3. Drag the app to `Applications` folder
4. **First Launch**: Right-click → Select "Open" → Click "Open" again (bypass Gatekeeper)

**Note**: App uses adhoc signature without Apple notarization, requires right-click "Open" on first launch

### iOS (Development Build - For Testing)
- Install via Xcode or Apple Configurator with IPA file
- Development IPA valid for 7 days, testing only
- For long-term use, consider joining Apple Developer Program

## 🛠️ Technology Stack

### Core Framework
- **Flutter SDK**: ^3.8.1
- **Dart SDK**: ^3.8.1
- **State Management**: GetX (^5.0.0)

### Main Dependencies
| Module | Package | Description |
|--------|---------|-------------|
| Video Player | `media_kit` (^1.2.0) | High-performance player based on libmpv |
| Network | `dio` (^5.3.3) | HTTP client |
| Local Storage | `shared_preferences` (^2.2.2) | Key-value storage |
| Cloud Sync | `webdav_client` (^1.2.2) | WebDAV protocol support |
| Danmaku Rendering | Custom `canvas_danmaku` | Canvas-based danmaku rendering |
| WebSocket | `web_socket_channel` (^3.0.1) | Real-time danmaku connection |
| Window Manager | `window_manager` (^0.5.0) | macOS window control |
| QR Code | `qr_flutter` + `mobile_scanner` | Bilibili login |
| Image Cache | `cached_network_image` (^3.3.0) | Network image caching |

### Platform Features
- **macOS**: Native window management, system volume control, media_kit player
- **iOS**: Mobile gestures, screen brightness control, battery display, media_kit player

## 📂 Repository Structure

**This repository contains source code only:**

```
Pure-Live/               # Source code repository
├── lib/                 # Flutter application source code ✅
│   ├── common/          # Shared services and components
│   ├── core/            # Platform protocols & business logic
│   ├── model/           # Data models
│   ├── modules/         # Feature modules (pages)
│   ├── pkg/             # Custom packages
│   ├── plugins/         # Plugins and tools
│   ├── routes/          # Route configuration
│   └── main.dart        # Application entry point
├── ios/                 # iOS platform code ✅
│   ├── Runner/          # App configuration
│   └── Runner.xcodeproj # Xcode project file
├── macos/               # macOS platform code ✅
│   ├── Runner/          # App configuration
│   └── Runner.xcodeproj # Xcode project file
├── scripts/             # Build and release scripts ✅
│   ├── build_and_release.sh
│   └── create_dmg_native.sh
├── README.md            # Project documentation ✅
├── README_EN.md         # English README ✅
└── LICENSE              # Open source license ✅
```

**⚠️ Files NOT included in this repository:**
```
❌ assets/               # Resource files (emojis, images, fonts)
❌ pubspec.yaml          # Dependencies configuration
❌ analysis_options.yaml # Code analysis rules
❌ build.yaml            # Build configuration
```

**To run this project:**
1. You need to configure `pubspec.yaml` and install dependencies
2. Asset files should be obtained from the full repository
3. See the Technology Stack section for detailed dependencies

## 📖 User Guide

### About the Player

This software uses [media_kit](https://pub.dev/packages/media_kit) as the player, based on libmpv implementation, supporting various video formats and live streaming protocols.

**Keyboard Shortcuts (macOS):**
- `Space` - Play/Pause
- `↑/↓` - Volume adjustment (+5% / -5%)
- `ESC` - Exit fullscreen
- `R` - Refresh playback

### About Cookies

Due to platform restrictions, watching Bilibili HD streams requires login. This software provides third-party OAuth authentication to obtain **Cookies**, without collecting any sensitive user information. User data is still managed by third-party platforms.

**Bilibili Login Steps:**
1. Settings → Account Management → Bilibili Login
2. Scan QR code with Bilibili App
3. Authorize to watch HD streams

### About WebDAV Sync

Supports syncing configuration and favorite data to the cloud via WebDAV protocol.

**Supported Services:**
- Jianguoyun (recommended)
- Nextcloud
- ownCloud
- Synology NAS
- Other WebDAV-compatible services

## ❓ FAQ

<details>
<summary><b>Q: Playback stuttering or not working?</b></summary>

**A**:
1. Check network connection
2. Try switching quality or stream route
3. Click "Refresh" button to reload
</details>

<details>
<summary><b>Q: Danmaku not showing?</b></summary>

**A**:
1. Check Settings → Danmaku Settings → Ensure "Danmaku Switch" is enabled
2. Confirm the stream has active comments
3. Try refreshing the player
</details>

<details>
<summary><b>Q: Cannot login to Bilibili?</b></summary>

**A**:
1. Ensure Bilibili App is logged in
2. Use the latest Bilibili App to scan QR code
3. Check network connection to Bilibili servers
</details>

<details>
<summary><b>Q: macOS app shows "damaged"?</b></summary>

**A**: Since the app is not notarized by Apple, first-time launch requires:
1. Right-click the app → Select "Open"
2. Click "Open" again in the dialog
3. Or allow in System Settings → Privacy & Security
</details>

## 📜 Disclaimer

This software is a **non-profit open source project** following the [**GPL-v3**](LICENSE) license. Please do not use this software for commercial purposes.

- This software does **NOT provide** VIP video cracking services
- HD playback requires appropriate permissions from respective platforms
- All content copyrights belong to their respective platforms
- This software is for educational purposes only. Please file an Issue if there are any copyright concerns

## 🔒 Privacy Policy

- ✅ Open source project with fully transparent code
- ✅ No ads, no viruses, no backdoors
- ✅ Does not collect personal user information
- ✅ Cookies only used for platform authentication, stored locally
- ✅ Supports self-hosted WebDAV cloud sync

## 📦 Source Repositories

This project is built and maintained based on the following source repositories (in chronological order):

1. **Primary Repository (Original Project)**
   [ice_live_viewer](https://github.com/Xmarmalade/ice_live_viewer)
   The initial project prototype, providing basic architecture and design concepts

2. **Secondary Repository (Multi-platform Extension)**
   [pure_live](https://github.com/Jackiu1997/pure_live)
   Extended multi-platform support, added danmaku features and UI optimization

3. **Tertiary Repository (Current Maintenance)**
   [pure_live](https://github.com/liuchuancong/pure_live)
   Currently active maintenance version, continuously updating features and fixing issues

This repository is based on the tertiary repository, focusing on **macOS** and **iOS** platform optimization and improvements.

## 📝 License

This project is licensed under [GPL-v3](LICENSE).

---

<p align="center">
Built with <a href="https://flutter.dev">Flutter</a>
</p>

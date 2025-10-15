#!/bin/bash
set -e

echo "🚀 构建 Pure Live macOS..."

# 清理和构建
flutter clean
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get
flutter build macos --release

# 打包
bash scripts/create_dmg_native.sh

# 验证
VERSION=$(grep 'version:' pubspec.yaml | head -1 | awk '{print $2}' | cut -d'+' -f1)
hdiutil verify build/macos/PureLive-macOS-${VERSION}.dmg

echo ""
echo "✅ 完成: build/macos/PureLive-macOS-${VERSION}.dmg"
ls -lh build/macos/PureLive-macOS-${VERSION}.dmg

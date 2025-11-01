#!/bin/bash
set -e

echo "🚀 构建 Pure Live iOS..."

# 获取版本号
VERSION=$(grep 'version:' pubspec.yaml | head -1 | awk '{print $2}' | cut -d'+' -f1)
BUILD_NUMBER=$(grep 'version:' pubspec.yaml | head -1 | awk '{print $2}' | cut -d'+' -f2)

echo "📦 版本: $VERSION (Build $BUILD_NUMBER)"

# 清理和构建
echo "🧹 清理缓存..."
flutter clean

echo "📥 获取依赖..."
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get

echo "🔨 构建 iOS Release..."
flutter build ios --release --no-codesign

# 构建路径
IOS_BUILD_DIR="./build/ios/Release-iphoneos"
APP_PATH="${IOS_BUILD_DIR}/Runner.app"
IPA_OUTPUT="./build/ios/PureLive-iOS-${VERSION}.ipa"

# 检查构建产物
if [ ! -d "$APP_PATH" ]; then
  echo "❌ 构建失败：找不到 $APP_PATH"
  exit 1
fi

# 创建 Payload 目录并打包 IPA
echo "📦 打包 IPA..."
rm -rf ./build/ios/Payload
mkdir -p ./build/ios/Payload
cp -R "$APP_PATH" ./build/ios/Payload/
cd ./build/ios
zip -r "PureLive-iOS-${VERSION}.ipa" Payload > /dev/null
cd ../..
rm -rf ./build/ios/Payload

echo ""
echo "✅ 完成: build/ios/PureLive-iOS-${VERSION}.ipa"
ls -lh "build/ios/PureLive-iOS-${VERSION}.ipa"
echo ""
echo "⚠️  注意：此 IPA 未签名，仅用于测试或通过 Xcode 安装"
echo "   如需 App Store 发布，请使用 Xcode Archive 功能"

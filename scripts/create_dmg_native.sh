#!/bin/bash
set -e

# 配置
APP_NAME="Pure-Live"
DMG_NAME="PureLive-macOS"
VERSION=$(grep 'version:' pubspec.yaml | head -1 | awk '{print $2}' | cut -d'+' -f1)
APP_PATH="./build/macos/Build/Products/Release/${APP_NAME}.app"
OUTPUT_DIR="./build/macos"
TEMP_DIR="/tmp/purelive_dmg"

# 检查应用
if [ ! -d "$APP_PATH" ]; then
  echo "❌ 找不到应用，请先运行: flutter build macos --release"
  exit 1
fi

# 制作 DMG
mkdir -p "$OUTPUT_DIR"
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
rm -f "$OUTPUT_DIR/${DMG_NAME}-${VERSION}.dmg"

cp -R "$APP_PATH" "$TEMP_DIR/"
ln -s /Applications "$TEMP_DIR/Applications"

hdiutil create -volname "Pure Live" \
  -srcfolder "$TEMP_DIR" \
  -ov -format UDZO \
  "$OUTPUT_DIR/${DMG_NAME}-${VERSION}.dmg" > /dev/null

rm -rf "$TEMP_DIR"

echo "✅ DMG: $OUTPUT_DIR/${DMG_NAME}-${VERSION}.dmg"

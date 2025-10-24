#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 读取版本号
VERSION=$(grep 'version:' pubspec.yaml | awk '{print $2}' | cut -d'+' -f1)
if [ -z "$VERSION" ]; then
  echo -e "${RED}❌ 无法读取版本号${NC}"
  exit 1
fi

echo -e "${BLUE}📦 开始创建 DMG 安装包（版本 ${VERSION}）${NC}"

# 设置变量
APP_NAME="Pure Live"
APP_PATH="build/macos/Build/Products/Release/pure_live.app"
DMG_NAME="PureLive-macOS-${VERSION}.dmg"
DMG_PATH="build/macos/${DMG_NAME}"
VOLUME_NAME="Pure Live ${VERSION}"
TEMP_DMG="temp.dmg"

# 检查应用是否存在
if [ ! -d "$APP_PATH" ]; then
  echo -e "${RED}❌ 应用未找到: $APP_PATH${NC}"
  echo -e "${YELLOW}请先运行: flutter build macos --release${NC}"
  exit 1
fi

echo -e "${GREEN}✓ 找到应用: $APP_PATH${NC}"

# 删除旧的 DMG
if [ -f "$DMG_PATH" ]; then
  echo -e "${YELLOW}🗑️  删除旧的 DMG 文件${NC}"
  rm -f "$DMG_PATH"
fi

if [ -f "$TEMP_DMG" ]; then
  rm -f "$TEMP_DMG"
fi

# 计算应用大小（MB）
APP_SIZE=$(du -sm "$APP_PATH" | awk '{print $1}')
# DMG 大小 = 应用大小 + 50MB 缓冲
DMG_SIZE=$((APP_SIZE + 50))

echo -e "${BLUE}📏 应用大小: ${APP_SIZE}MB, DMG 大小: ${DMG_SIZE}MB${NC}"

# 创建临时 DMG
echo -e "${BLUE}🔨 创建临时 DMG...${NC}"
hdiutil create -size ${DMG_SIZE}m -fs HFS+ -volname "$VOLUME_NAME" "$TEMP_DMG" -ov -quiet

# 挂载临时 DMG
echo -e "${BLUE}📂 挂载临时 DMG...${NC}"
MOUNT_DIR=$(hdiutil attach "$TEMP_DMG" -readwrite -noverify -noautoopen | grep "/Volumes/${VOLUME_NAME}" | awk '{print $3}')

if [ -z "$MOUNT_DIR" ]; then
  echo -e "${RED}❌ 挂载失败${NC}"
  rm -f "$TEMP_DMG"
  exit 1
fi

echo -e "${GREEN}✓ 挂载到: $MOUNT_DIR${NC}"

# 复制应用到 DMG
echo -e "${BLUE}📋 复制应用到 DMG...${NC}"
cp -R "$APP_PATH" "$MOUNT_DIR/"

# 创建 Applications 符号链接
echo -e "${BLUE}🔗 创建 Applications 符号链接...${NC}"
ln -s /Applications "$MOUNT_DIR/Applications"

# 卸载 DMG
echo -e "${BLUE}💾 卸载 DMG...${NC}"
hdiutil detach "$MOUNT_DIR" -quiet

# 转换为最终的压缩 DMG
echo -e "${BLUE}🗜️  压缩 DMG...${NC}"
mkdir -p "build/macos"
hdiutil convert "$TEMP_DMG" -format UDZO -o "$DMG_PATH" -ov -quiet

# 清理临时文件
rm -f "$TEMP_DMG"

# 检查最终文件
if [ -f "$DMG_PATH" ]; then
  DMG_SIZE_MB=$(du -m "$DMG_PATH" | awk '{print $1}')
  echo -e "${GREEN}✅ DMG 创建成功！${NC}"
  echo -e "${GREEN}📦 文件路径: ${DMG_PATH}${NC}"
  echo -e "${GREEN}📏 文件大小: ${DMG_SIZE_MB}MB${NC}"
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
else
  echo -e "${RED}❌ DMG 创建失败${NC}"
  exit 1
fi

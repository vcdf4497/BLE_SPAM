#!/bin/bash
# Build script for BLE Spam FAP (Flipper Application Package)
# Tested on: Ubuntu 20.04 LTS, macOS 11+, WSL2 Windows
# Requires: FDT (Flipper Development Toolkit)

set -e  # Exit on error

PROJECT_NAME="ble_spam"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$PROJECT_DIR/build"
DIST_DIR="$PROJECT_DIR/dist"

echo "=================================================="
echo "🔨 BLE Spam FAP Builder v7.0"
echo "=================================================="
echo ""
echo "📁 Project: $PROJECT_NAME"
echo "📂 Source:  $PROJECT_DIR"
echo "🏗️  Build:   $BUILD_DIR"
echo ""

# Clean previous build
if [ -d "$BUILD_DIR" ]; then
    echo "🧹 Cleaning previous build..."
    rm -rf "$BUILD_DIR"
fi

# Create build directories
mkdir -p "$BUILD_DIR"
mkdir -p "$DIST_DIR"

# Build with CMake (requires FDT)
echo "🔨 Building FAP..."
cd "$BUILD_DIR"

cmake .. \
    -DCMAKE_TOOLCHAIN_FILE="$FLIPPER_DEV_TOOLS/cmake/gnu_arm_toolchain.cmake" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_FAP=ON

make -j$(nproc) || make -j4

# Check if build succeeded
if [ -f "$BUILD_DIR/$PROJECT_NAME.fap" ]; then
    echo ""
    echo "✅ Build successful!"
    echo "📦 Package: $BUILD_DIR/$PROJECT_NAME.fap"
    
    # Copy to dist
    cp "$BUILD_DIR/$PROJECT_NAME.fap" "$DIST_DIR/$PROJECT_NAME.fap"
    
    # Show file info
    ls -lh "$DIST_DIR/$PROJECT_NAME.fap"
    
    echo ""
    echo "🎉 Ready for deployment!"
    echo ""
    echo "Next steps:"
    echo "1. Connect Flipper via USB"
    echo "2. Use qFlipper or drag-drop to: /ext/apps/bluetooth/"
    echo "3. Launch: Apps → Bluetooth → BLE Spam"
    echo ""
else
    echo ""
    echo "❌ Build failed!"
    echo "Check the error messages above."
    exit 1
fi

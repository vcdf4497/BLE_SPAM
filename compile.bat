@echo off
REM Compilation script for BLE Spam FAP
REM Flipper Zero - Windows

setlocal enabledelayedexpansion

set PROJECT_DIR=c:\Users\Lucas\Downloads\Flipper\ble_spam
set SDK_DIR=C:\flipperzero-firmware
set BUILD_DIR=%PROJECT_DIR%\build
set OUTPUT_DIR=%PROJECT_DIR%\dist
set TOOLCHAIN=%SDK_DIR%\toolchain\x86_64-windows\bin

echo.
echo ================================================
echo   BLE Spam v7.0 - Compilation Script
echo ================================================
echo.

REM Create build directories
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

cd /d "%BUILD_DIR%"

REM Check compiler
if not exist "%TOOLCHAIN%\arm-none-eabi-gcc.exe" (
    echo ERROR: ARM compiler not found!
    echo Path: %TOOLCHAIN%\arm-none-eabi-gcc.exe
    pause
    exit /b 1
)

echo [*] Compiler found: %TOOLCHAIN%\arm-none-eabi-gcc.exe
echo [*] Building BLE Spam v7.0...
echo.

REM Run CMake
echo [1/3] Configuring CMake...
cmake .. -DCMAKE_TOOLCHAIN_FILE="%SDK_DIR%\cmake\gnu_arm_toolchain.cmake" ^
         -DCMAKE_BUILD_TYPE=Release ^
         -DBUILD_FAP=ON

if errorlevel 1 (
    echo ERROR: CMake configuration failed!
    pause
    exit /b 1
)

echo.
echo [2/3] Compiling...
cmake --build . --config Release -j 4

if errorlevel 1 (
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)

echo.
echo [3/3] Packaging FAP...

REM Find and copy .fap file
for /r "%BUILD_DIR%" %%f in (ble_spam.fap) do (
    echo Found: %%f
    copy "%%f" "%OUTPUT_DIR%\ble_spam.fap"
    if exist "%OUTPUT_DIR%\ble_spam.fap" (
        echo.
        echo ================================================
        echo   ✅ SUCCESS!
        echo ================================================
        echo.
        echo Package: %OUTPUT_DIR%\ble_spam.fap
        for %%A in ("%OUTPUT_DIR%\ble_spam.fap") do echo Size: %%~zA bytes
        echo.
        echo Next steps:
        echo 1. Open qFlipper
        echo 2. Install from file: %OUTPUT_DIR%\ble_spam.fap
        echo 3. Launch on Flipper!
        echo.
        pause
        exit /b 0
    )
)

echo.
echo ERROR: .fap file not found in build output!
echo Checked: %BUILD_DIR%
dir /s /b "%BUILD_DIR%\*.fap"
pause
exit /b 1

# BLE Spam - Version 6.7 Improvements

## Overview
Enhanced BLE advertisement flooding tool with optimizations for modern iOS 17+, Android 13+, and Windows 11+ devices.

## Key Improvements

### 1. **Enhanced Connection Request Transmission**
- **Optimized BLE Advertisement Intervals**: Reduced variance (1.25x vs 1.5x) for more consistent device detection
- **Improved TX Power Settings**: Increased TX power to maximum (8) for better signal propagation and longer range
- **Packet Size Validation**: Added safety checks to ensure BLE packet integrity (0-31 bytes)

### 2. **iOS 17+ Apple Continuity Optimization**
- **Proximity Pair Enhancement**: Improved AirPods/Beats popup detection with enhanced battery status simulation
- **Nearby Action Alerts**: Optimized action flags (0xC0) for maximum popup frequency on Setup/AppleTV/HomePod
- **Custom Crash Attack**: Enhanced payload for iOS 17 lockup scenarios
- **Encrypted Payload Support**: Full 16-byte AES-GCM encrypted payload for Proximity Pair

### 3. **Android 13+ FastPair Modernization**
- **Service UUID Advertisement**: Complete 16-bit UUID list advertisement for device discovery
- **Service Data Optimization**: Enhanced Android device detection with proper Company ID format
- **TX Power Optimization**: Realistic RSSI values (-100 to +20 dBm) for accurate range calculation
- **Model Cycling**: Accelerated model bruteforce (15 iterations vs 10) for faster pairing discovery

### 4. **Samsung Galaxy Devices Enhancement** 
- **EasySetup Buds**: Improved Galaxy Buds Pro/2/Live advertisement packets
- **Watch Compatibility**: Galaxy Watch 5/6 Pro optimized payload structure
- **Extended Advertisement**: Secondary manufacturer-specific data for Android 13+ support
- **Color Model Support**: Full color variant detection for accurate device matching

### 5. **Windows 11+ SwiftPair Optimization**
- **Beacon ID Enhancement**: Proper Microsoft Beacon signature (0x03) for SwiftPair detection
- **Sub-Scenario Support**: Standard pairing scenario (0x00) for maximum compatibility
- **TX Power Indicator**: Proper RSSI byte (0x80) for Windows 11 Fast Pair detection
- **Device Name Handling**: Optimized string length handling for device name advertisement

### 6. **Advanced Bruteforce Acceleration**
- **Faster Cycling**: Increased counter threshold from 10 to 15 for accelerated model enumeration
- **Adaptive Timing**: Dynamic delay timing for burst-mode transmission
- **Packet Counting**: Internal counter for transmission statistics

### 7. **Code Quality Improvements**
- **Error Handling**: Enhanced null pointer checks and memory safety
- **Documentation**: Detailed comments on BLE advertisement format and device-specific optimizations
- **Resource Management**: Improved packet allocation/deallocation safety
- **API Compatibility**: Full compatibility with FuriHAL BLE extra beacon API

## Technical Details

### BLE Advertisement Structure
```
Manufacturer Specific Data (0xFF)
├── Company ID (Little Endian)
├── Protocol Data
│   ├── Device Model/ID
│   ├── Status Information
│   ├── Battery/Color Data
│   └── Encrypted Payload (iOS 17+)
└── TX Power Level (0x0A)
```

### Protocol Support Matrix

| Platform | Protocol | Version | Status |
|----------|----------|---------|--------|
| iOS | Continuity | 17+ | ✓ Enhanced |
| macOS | AirDrop | 12+ | ✓ Optimized |
| Android | FastPair | 13+ | ✓ Enhanced |
| Samsung | EasySetup | A13+ | ✓ Optimized |
| Windows | SwiftPair | 11+ | ✓ Enhanced |
| Generic | Multiple | All | ✓ Supported |

## Performance Metrics

- **TX Power**: Maximum (+8 dBm) for optimal range
- **Advertisement Interval**: 30-500ms (configurable)
- **Packet Rate**: Accelerated bruteforce (15 cycles vs 10)
- **Device Coverage**: iOS 17+, Android 13+, Windows 11+

## Version History

- **6.7**: Enhanced connection requests for modern platforms
- **6.6**: Previous stable version
- **6.0-6.5**: Earlier versions

## Testing & Compatibility

Tested and verified on:
- iPhone 15 Pro/Pro Max (iOS 17+)
- Samsung Galaxy S24 (Android 14)
- Galaxy Watch 6 Pro
- Windows 11 22H2
- Flipper Zero (Latest firmware)

## Notes

- Some platforms may require SwiftUI/Material UI updates for full detection
- Range varies by device and environmental factors
- Keep Flipper's BLE antenna oriented toward target device for best results
- Refer to original repository for additional information

---

**Last Updated**: January 13, 2026
**Author**: Enhanced by Rogue Master Fork Contributor

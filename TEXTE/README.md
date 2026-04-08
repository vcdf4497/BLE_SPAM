# BLE Spam for OFW / Rogue Master

![](https://thumb.tildacdn.com/tild3332-3839-4061-b663-363464303432/-/resize/214x/-/format/webp/noroot.png)

## What

This Flipper application ("FAP") spams broadcast packets to Apple, Android, and Windows devices, optimized for iOS 17+, Android 13+, and Windows 11+ platforms.

**Current Version**: 6.7 | **Latest Optimization**: v6.8 (Planned Q1 2026)

## ✨ Key Features

- 🍎 **Apple Continuity**: Proximity Pair, Nearby Action, iOS Crash
- 🤖 **Android FastPair**: Device connection simulation
- 📱 **Samsung EasySetup**: Galaxy Buds & Watch detection
- 🪟 **Windows SwiftPair**: Device discovery
- 🎯 **Multiple Attack Modes**: Kitchen Sink (all at once), Bruteforce, Sequential
- ⚙️ **Configurable Timing**: 20ms, 30ms, 50ms, 100ms, 200ms intervals
- 🔄 **Random MAC**: Anti-tracking randomization
- 📊 **LED Indicator**: Real-time status feedback

## 📚 Documentation & Optimization Guides

### For v6.8+ Optimizations (New!)

We've created comprehensive guides for improving compatibility, stability, and security:

| Document | Purpose | Audience |
|----------|---------|----------|
| **[EXECUTIVE_SUMMARY.md](EXECUTIVE_SUMMARY.md)** | Overview, timeline, metrics | Managers, Tech Leads |
| **[OPTIMIZATION_ROADMAP.md](OPTIMIZATION_ROADMAP.md)** | Detailed improvement phases | Architecture, Planning |
| **[IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md)** | Code snippets, modifications | Developers |
| **[SECURITY_GUIDE.md](SECURITY_GUIDE.md)** | Security fixes, hardening | Security, QA |
| **[TESTING_GUIDE.md](TESTING_GUIDE.md)** | Test scenarios, validation | QA, Testers |
| **[NAVIGATION_GUIDE.md](NAVIGATION_GUIDE.md)** | How to use all documents | Everyone |

**👉 [Start Here: NAVIGATION_GUIDE.md](NAVIGATION_GUIDE.md)** for quick orientation

## Builds

Published (options):
* [FlipC.org](https://flipc.org/noproto/ble_spam_ofw?branch=master)
  * Download the FAP at the above link then copy the FAP to its respective apps/ directory (Bluetooth) on your Flipper Zero device (using qFlipper or manually copying it to the SD)
* [RogueMaster firmware](https://github.com/RogueMaster/flipperzero-firmware-wPlugins/releases/latest)
  * Built in to every release, you're good to go!

## Version History

### v6.7 (Current - January 2026)
- ✅ iOS 17+ optimization
- ✅ Android 13+ compatibility  
- ✅ Windows 11+ support
- ✅ Samsung Galaxy support
- ✅ Enhanced BLE intervals
- ⚠️ See OPTIMIZATION_ROADMAP.md for v6.8+ improvements

### v6.8 (Planned - March 2026)
- 🔧 **In Progress**: See [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md)
- Continuity payload enhancement
- Adaptive delay optimization
- Security hardening
- Samsung advanced support (Galaxy Z Fold/Flip)

### v6.9+ (Roadmap)
- Range mode implementation
- Advanced logging & analytics
- Additional device support

See [OPTIMIZATION_ROADMAP.md](OPTIMIZATION_ROADMAP.md) for full timeline.

## ✅ Compatibility Matrix

### Fully Supported
| Platform | Version | Protocol | Status |
|----------|---------|----------|--------|
| iOS | 17.0+ | Continuity | ✅ Enhanced |
| Android | 13.0+ | FastPair | ✅ Enhanced |
| Samsung | A13+ | EasySetup | ✅ Enhanced |
| Windows | 11.0+ | SwiftPair | ✅ Enhanced |
| macOS | 14.0+ | AirDrop/Continuity | ✅ Supported |

See [OPTIMIZATION_ROADMAP.md](OPTIMIZATION_ROADMAP.md) § Matrice de Compatibilité for details.

## 🚀 Getting Started

1. **Flash Flipper**: Use RogueMaster firmware (BLE Spam included)
2. **Open App**: Bluetooth → BLE Spam
3. **Select Attack**: Choose from 11 attack modes
4. **Adjust Timing**: Use ↑↓ to change delay (20-200ms)
5. **Start**: Press OK to begin, Back to stop

## ⚙️ Advanced Configuration

See `application.fam` for version and metadata configuration.

For detailed implementation changes, see [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md).

## 🔒 Security Notes

- Payload validation implemented (v6.8+)
- Buffer overflow protection (planned v6.8)
- NULL pointer checks throughout
- Memory leak prevention patterns
- See [SECURITY_GUIDE.md](SECURITY_GUIDE.md) for details

## 🧪 Testing

Comprehensive test scenarios available in [TESTING_GUIDE.md](TESTING_GUIDE.md):
- Functional tests (iOS, Android, Windows, Samsung)
- Performance tests (stability, battery, range)
- Security tests (buffer overflow, memory, race conditions)

## 💡 Contributing

Contributions welcome! Please review:
1. [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md) for code standards
2. [SECURITY_GUIDE.md](SECURITY_GUIDE.md) for security requirements
3. [TESTING_GUIDE.md](TESTING_GUIDE.md) for validation procedures

## Credit

**Original Creator**: [WillyJL](https://github.com/RogueMaster/flipperzero-firmware-wPlugins/commit/db2038297fe8a8aed561601f93328d0cd0e7690d)

**Contributors**:
- @WillyJL - Core architecture & Continuity protocol
- @ECTO-1A - iOS crash mode & advanced optimization
- @Spooks4576 - Android & Windows protocols
- @RogueMaster - Firmware integration & maintenance

**Research & References**:
- Continuity structures & Nearby Action IDs: https://github.com/furiousMAC/continuity/
- Proximity Pair IDs: https://github.com/ECTO-1A/AppleJuice/
- AirTag research: https://techryptic.github.io/2023/09/01/Annoying-Apple-Fans/
- Google FastPair Spec: https://developers.google.com/nearby/fast-pair
- Bluetooth Spec: https://www.bluetooth.com/specifications/

## 📋 Version Information

- **Current**: v6.7 (January 13, 2026)
- **Latest Optimization Docs**: January 13, 2026
- **Target Release v6.8**: March 2026
- **Next Optimization Review**: Quarterly

See [IMPROVEMENTS.md](IMPROVEMENTS.md) for detailed changelog and [OPTIMIZATION_ROADMAP.md](OPTIMIZATION_ROADMAP.md) for future plans.

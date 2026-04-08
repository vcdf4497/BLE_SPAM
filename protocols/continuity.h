#pragma once
#include "_base.h"

// Hacked together by @WillyJL
// iOS 17 Crash by @ECTO-1A
// Nearby Action IDs and Documentation at https://github.com/furiousMAC/continuity/
// Proximity Pair IDs from https://github.com/ECTO-1A/AppleJuice/

// Battery simulation for realistic Continuity payloads
typedef struct {
    uint8_t level;        // 0-100%
    bool is_charging;     // Charging status
    bool case_open;       // Case open (for earbuds)
} BatteryStatus;

typedef enum {
    ContinuityTypeAirDrop = 0x05,
    ContinuityTypeProximityPair = 0x07,
    ContinuityTypeAirplayTarget = 0x09,
    ContinuityTypeHandoff = 0x0C,
    ContinuityTypeTetheringSource = 0x0E,
    ContinuityTypeNearbyAction = 0x0F,
    ContinuityTypeNearbyInfo = 0x10,

    ContinuityTypeCustomCrash,
    ContinuityTypeCOUNT
} ContinuityType;

typedef enum {
    ContinuityPpBruteforceModel,
    ContinuityPpBruteforceColor,
} ContinuityPpBruteforce;

typedef struct {
    ContinuityType type;
    union {
        struct {
            ContinuityPpBruteforce bruteforce_mode;
            uint16_t model;
            uint8_t color;
            uint8_t prefix;
            BatteryStatus battery;  // NEW: Battery simulation
        } proximity_pair;
        struct {
            uint8_t action;
            uint8_t flags;
            BatteryStatus battery;  // NEW: Battery simulation
        } nearby_action;
    } data;
} ContinuityCfg;

extern const Protocol protocol_continuity;

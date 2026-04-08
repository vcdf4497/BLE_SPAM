# CMakeLists.txt - BLE Spam Build Configuration
# Optimized for Flipper Zero / Rogue Master
# Supports modern Flipper OS versions 0.97.0+

cmake_minimum_required(VERSION 3.20)
project(ble_spam C CXX)

# ============================================================================
# Configuration
# ============================================================================

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wpedantic")

# Optimization flags
set(CMAKE_C_FLAGS_DEBUG "-O0 -g3 -DDEBUG=1")
set(CMAKE_C_FLAGS_RELEASE "-O2 -DNDEBUG")

# ============================================================================
# Project Settings
# ============================================================================

set(PROJECT_VERSION "7.0")
set(PROJECT_AUTHOR "WillyJL & ECTO-1A & Spooks4576")
set(PROJECT_DESCRIPTION "Aggressive BLE spam for Flipper Zero")

# Target platform
set(TARGET_PLATFORM "Flipper Zero" CACHE STRING "Target platform")
set(TARGET_FW_VERSION "0.97.0" CACHE STRING "Minimum Flipper OS version")

# ============================================================================
# Source Files
# ============================================================================

set(SOURCES
    # Core application
    ble_spam.c
    
    # UI/Scenes
    scenes/main.c
    scenes/config.c
    scenes/_setup.c
    
    # Protocols
    protocols/_protocols.c
    protocols/continuity.c
    protocols/fastpair.c
    protocols/easysetup.c
    protocols/swiftpair.c
    protocols/nameflood.c
    protocols/lovespouse.c
)

# ============================================================================
# Headers
# ============================================================================

set(HEADERS
    ble_spam.h
    scenes/_setup.h
    scenes/_scenes.h
    protocols/_base.h
    protocols/_protocols.h
)

# ============================================================================
# Create Target
# ============================================================================

add_library(ble_spam ${SOURCES} ${HEADERS})

# ============================================================================
# Include Directories
# ============================================================================

target_include_directories(ble_spam PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/protocols
    ${CMAKE_CURRENT_SOURCE_DIR}/scenes
)

# ============================================================================
# Compiler Flags & Optimizations
# ============================================================================

# Security hardening
target_compile_options(ble_spam PRIVATE
    -fstack-protector-strong
    -fno-omit-frame-pointer
    -Wformat=2
    -Wformat-security
)

# Code Quality
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(ble_spam PRIVATE
        -fsanitize=address
        -fsanitize=undefined
    )
endif()

# ============================================================================
# Memory & Performance Tuning
# ============================================================================

# Define memory constraints for Flipper Zero
target_compile_definitions(ble_spam PUBLIC
    TARGET_FLIPPER_ZERO=1
    FLIPPER_OS_VERSION_MIN=0x0097
    MAX_BLE_PACKET_SIZE=31
    STACK_SIZE=4096  # Increased from 2048 for stability
    ADAPTIVE_DELAY_ENABLED=1
    FEATURE_LED_INDICATOR=1
    FEATURE_LOCK_KEYBOARD=1
    FEATURE_LOGGING=1
)

# ============================================================================
# Compiler Warnings as Errors (Optional)
# ============================================================================

option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)
if(WARNINGS_AS_ERRORS)
    target_compile_options(ble_spam PRIVATE -Werror)
endif()

# ============================================================================
# Static Analysis (Optional)
# ============================================================================

option(ENABLE_CLANG_TIDY "Enable ClangTidy static analysis" OFF)
if(ENABLE_CLANG_TIDY)
    find_program(CLANG_TIDY clang-tidy)
    if(CLANG_TIDY)
        set_target_properties(ble_spam PROPERTIES
            C_CLANG_TIDY "${CLANG_TIDY};-checks=clang-analyzer-*,cppcoreguidelines-*"
        )
    endif()
endif()

# ============================================================================
# Testing (Optional)
# ============================================================================

option(ENABLE_TESTS "Build tests" OFF)
if(ENABLE_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# ============================================================================
# Install Rules (Optional)
# ============================================================================

install(TARGETS ble_spam
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

install(FILES ${HEADERS} DESTINATION include/ble_spam)

# ============================================================================
# Print Configuration Summary
# ============================================================================

message(STATUS "=== BLE Spam Build Configuration ===")
message(STATUS "Project: ${PROJECT_NAME} v${PROJECT_VERSION}")
message(STATUS "Target: ${TARGET_PLATFORM}")
message(STATUS "Min FW: ${TARGET_FW_VERSION}")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C Standard: ${CMAKE_C_STANDARD}")
message(STATUS "Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "====================================")

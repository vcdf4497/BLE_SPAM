#include "../ble_spam.h"
#include <furi_hal_bt.h>

// TX power level labels (index 0-7 maps to GapAdvPowerLevel enum values)
static const char* const tx_power_labels[] = {
    "-40dBm",
    "-20dBm",
    "-16dBm",
    "-12dBm",
    "-8dBm",
    "-4dBm",
    "0dBm",
    "+6dBm (Max)",
};
#define TX_POWER_COUNT ((uint8_t)COUNT_OF(tx_power_labels))

static void settings_tx_power_callback(VariableItem* item) {
    Ctx* ctx = variable_item_get_context(item);
    ctx->adv_power = variable_item_get_current_value_index(item);
    variable_item_set_current_value_text(item, tx_power_labels[ctx->adv_power]);
}

static void settings_adaptive_delay_callback(VariableItem* item) {
    Ctx* ctx = variable_item_get_context(item);
    ctx->adaptive_delay = variable_item_get_current_value_index(item);
    variable_item_set_current_value_text(item, ctx->adaptive_delay ? "ON" : "OFF");
}

static void settings_led_callback(VariableItem* item) {
    Ctx* ctx = variable_item_get_context(item);
    ctx->led_indicator = variable_item_get_current_value_index(item);
    variable_item_set_current_value_text(item, ctx->led_indicator ? "ON" : "OFF");
}

void scene_settings_on_enter(void* _ctx) {
    Ctx* ctx = _ctx;
    VariableItemList* list = ctx->variable_item_list;

    variable_item_list_set_header(list, "Global Settings");

    // TX Power
    VariableItem* item_power =
        variable_item_list_add(list, "TX Power", TX_POWER_COUNT, settings_tx_power_callback, ctx);
    variable_item_set_current_value_index(item_power, ctx->adv_power);
    variable_item_set_current_value_text(item_power, tx_power_labels[ctx->adv_power]);

    // Adaptive Delay
    VariableItem* item_delay = variable_item_list_add(
        list, "Adaptive Delay", 2, settings_adaptive_delay_callback, ctx);
    variable_item_set_current_value_index(item_delay, ctx->adaptive_delay);
    variable_item_set_current_value_text(item_delay, ctx->adaptive_delay ? "ON" : "OFF");

    // LED Indicator
    VariableItem* item_led =
        variable_item_list_add(list, "LED Indicator", 2, settings_led_callback, ctx);
    variable_item_set_current_value_index(item_led, ctx->led_indicator);
    variable_item_set_current_value_text(item_led, ctx->led_indicator ? "ON" : "OFF");

    variable_item_list_set_selected_item(
        list, scene_manager_get_scene_state(ctx->scene_manager, SceneSettings));

    view_dispatcher_switch_to_view(ctx->view_dispatcher, ViewVariableItemList);
}

bool scene_settings_on_event(void* _ctx, SceneManagerEvent event) {
    Ctx* ctx = _ctx;
    if(event.type == SceneManagerEventTypeBack) {
        scene_manager_previous_scene(ctx->scene_manager);
        return true;
    } else if(event.type == SceneManagerEventTypeCustom) {
        uint32_t index = event.event;
        scene_manager_set_scene_state(ctx->scene_manager, SceneSettings, index);
    }
    return false;
}

void scene_settings_on_exit(void* _ctx) {
    Ctx* ctx = _ctx;
    variable_item_list_reset(ctx->variable_item_list);
}

#include QMK_KEYBOARD_H
#include "version.h"
#include "features/achordion.h"

uint16_t achordion_timeout(uint16_t tap_hold_keycode) {
    if (IS_QK_LAYER_TAP(tap_hold_keycode)) {
        return 0;
    } else if (tap_hold_keycode == MT(MOD_LSFT, KC_ESC)) {
        return 0;
    }

    return 1000; // Otherwise use a timeout of 1000 ms
}

uint16_t get_quick_tap_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case MT(MOD_LSFT, KC_N):
        case MT(MOD_LCTL, KC_E):
        case MT(MOD_LGUI, KC_I):
            return 150;
        default:
            return 0;
    }
}

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    if (IS_QK_LAYER_TAP(keycode)) {
        return 160;
    }

    return 200;
}

bool get_retro_tapping(uint16_t keycode, keyrecord_t *record) {
    if (IS_QK_LAYER_TAP(keycode)) {
        return false;
    }

    return true;
}

bool get_permissive_hold(uint16_t keycode, keyrecord_t *record) {
    if (IS_QK_LAYER_TAP(keycode)) {
        return true;
    } else if (keycode == MT(MOD_LSFT, KC_ESC)) {
        return true;
    }

    return false;
}

void matrix_scan_user(void) {
    achordion_task();
}

// This function often already exists in your keymap.c file, so you can just add the process_achordion call to it.
/*bool process_record_user(uint16_t keycode, keyrecord_t *record) {*/
/*  if (!process_achordion(keycode, record)) {*/
/*    return false;*/
/*  }*/
/**/
/*  return true;*/
/*}*/

// OLED Display

#ifdef OLED_ENABLE

void fill_screen(char *str) {
    for (int i = 0; i < 5; i++) {
        oled_set_cursor(0, i);
        oled_write(str, false);
    }
}

bool oled_task_master(void) {
    // Host Keyboard Layer Status
    /*oled_write_P(PSTR("Layer: "), false);*/

    switch (get_highest_layer(layer_state)) {
        case 0:
            fill_screen("Base\n");
            break;
        case 1:
            fill_screen("Navigation\n");
            break;
        case 2:
            fill_screen("Numbers\n");
            break;
        case 3:
            fill_screen("Symbols\n");
            break;
        case 4:
            fill_screen("Function\n");
            break;
        case 5:
            fill_screen("Mods\n");
            break;
        case 6:
            fill_screen("QWERTY\n");
            break;
        default:
            // Or use the write_ln shortcut over adding '\n' to the end of your string
            oled_write_ln_P(PSTR("Undefined"), false);
    }

    return false;
}

bool oled_task_indentured_servant(void) {
    oled_write(get_u8_str(get_current_wpm(), '0'), false);
    return false;
}

bool oled_task_user(void) {
    if (is_keyboard_master()) {
        return oled_task_master();
    } else {
        return oled_task_indentured_servant();
    }

    return false;
}

void oled_render_boot(bool bootloader) {
    oled_clear();
    for (int i = 0; i < 4; i++) {
        oled_set_cursor(0, i);
        if (bootloader) {
            oled_write_P(PSTR("Awaiting New Firmware "), false);
        } else {
            oled_write_P(PSTR("Rebooting "), false);
        }
    }

    oled_render_dirty(true);
}

bool shutdown_user(bool jump_to_bootloader) {
    oled_render_boot(jump_to_bootloader);

    return true;
}

#endif

#ifdef RGB_MATRIX_ENABLE
extern rgb_config_t rgb_matrix_config;

void keyboard_post_init_user(void) {
    rgb_matrix_enable();
}

extern const uint8_t PROGMEM ledmap[][RGB_MATRIX_LED_COUNT][3];
void                         set_layer_color(int layer) {
    for (int i = 0; i < RGB_MATRIX_LED_COUNT; i++) {
        HSV hsv = {
                                    .h = pgm_read_byte(&ledmap[layer][i][0]),
                                    .s = pgm_read_byte(&ledmap[layer][i][1]),
                                    .v = pgm_read_byte(&ledmap[layer][i][2]),
        };
        if (!hsv.h && !hsv.s && !hsv.v) {
            rgb_matrix_set_color(i, 0, 0, 0);
        } else {
            RGB   rgb = hsv_to_rgb(hsv);
            float f   = (float)rgb_matrix_config.hsv.v / UINT8_MAX;
            rgb_matrix_set_color(i, f * rgb.r, f * rgb.g, f * rgb.b);
        }
    }
}

bool rgb_matrix_indicators_user(void) {
    switch (biton32(layer_state)) {
        case 0:
            set_layer_color(0);
            break;
        case 1:
            set_layer_color(1);
            break;
        case 2:
            set_layer_color(2);
            break;
        case 3:
            set_layer_color(3);
            break;
        case 4:
            set_layer_color(4);
            break;
        case 5:
            set_layer_color(5);
            break;
        default:
            if (rgb_matrix_get_flags() == LED_FLAG_NONE) rgb_matrix_set_color_all(0, 0, 0);
            break;
    }
    return true;
}
#endif

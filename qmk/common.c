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
    case LT(2, KC_BSPC):
    case LT(4, KC_TAB):
      return 150;
    default:
      return 0;
  }
}

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
  if (IS_QK_LAYER_TAP(keycode)) {
    return 125;
  }

  return 180;
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

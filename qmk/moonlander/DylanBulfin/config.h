/*
  Set any config.h overrides for your specific keymap here.
  See config.h options at https://docs.qmk.fm/#/config_options?id=the-configh-file
*/
#define ORYX_CONFIGURATOR
#define RETRO_TAPPING

#define DUMMY_MOD_NEUTRALIZER_KEYCODE KC_RIGHT_CTRL
#define MODS_TO_NEUTRALIZE { MOD_LGUI, MOD_LALT }

#define USB_SUSPEND_WAKEUP_DELAY 0
#define FIRMWARE_VERSION u8"EoZp5/x4anW"
#define RAW_USAGE_PAGE 0xFF60
#define RAW_USAGE_ID 0x61
#define LAYER_STATE_8BIT

#define RGB_MATRIX_STARTUP_SPD 60

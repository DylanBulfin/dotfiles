#define PERMISSIVE_HOLD_PER_KEY

#define TAPPING_TERM_PER_KEY

#define QUICK_TAP_TERM_PER_KEY

#define ACHORDION_STREAK

#define DUMMY_MOD_NEUTRALIZER_KEYCODE KC_RIGHT_CTRL

#ifdef MODS_TO_NEUTRALIZE
#undef MODS_TO_NEUTRALIZE
#define MODS_TO_NEUTRALIZE { MOD_LGUI, MOD_LALT }
#endif


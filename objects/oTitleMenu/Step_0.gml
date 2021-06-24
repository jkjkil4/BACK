event_inherited();

aph = clamp(aph + (global.sys.focusedWidget() == id ? 0.15 : -0.15), 0, 1);
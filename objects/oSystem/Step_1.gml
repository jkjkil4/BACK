if(DEBUG) {
	//打开调试菜单
	if(keyboard_check_pressed(vk_f12) && !instance_exists(oDebugMenu))
		instance_create_layer(20, scrViewH(0) / 4, "System", oDebugMenu);
}

//ESC菜单
if(keyboard_check_pressed(vk_escape) && instance_exists(oPlayer_Active))
	instance_create_layer(scrViewW(0) / 2, 100, "System", oPauseMenu);

//切换全屏
if(keyboard_check_pressed(vk_f11))
	 window_set_fullscreen(!window_get_fullscreen());
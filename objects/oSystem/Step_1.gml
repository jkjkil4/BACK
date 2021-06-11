if(DEBUG) {
	//打开调试菜单
	if(keyboard_check_pressed(vk_f12))
		scrCreateDebugMenu(20, scrViewH(0) / 4);
}

//切换全屏
if(keyboard_check_pressed(vk_f11)) {
	 window_set_fullscreen(!window_get_fullscreen());	
}

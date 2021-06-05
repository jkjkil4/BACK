if(DEBUG) {
	//控制特殊物件(碰撞箱等)显示
	if(keyboard_check_pressed(ord("K")))
		global.specVisible = !global.specVisible;
	
	//控制room_speed
	if(keyboard_check_pressed(ord("I")))
		room_speed = 20;
	if(keyboard_check_pressed(ord("O")))
		room_speed = 60;
	if(keyboard_check_pressed(ord("P")))
		room_speed = 90;
	
	//移动玩家
	if(instance_exists(oPlayer)) {
		if(keyboard_check_pressed(ord("M"))) {
			oPlayer.x = mouse_x;
			oPlayer.y = mouse_y;
			oPlayer.xprevious = mouse_x;
			oPlayer.yprevious = mouse_y;
		}
	}
}

//切换全屏
if(keyboard_check_pressed(vk_f11)) {
	 window_set_fullscreen(!window_get_fullscreen());	
}

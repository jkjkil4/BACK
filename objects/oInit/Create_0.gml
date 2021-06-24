global.save = {
	index : 0,
	deathCount : 0
};
global.roomMap = ds_map_create();
global.roomMap[? "rGame"] = rGame;
global.roomMap[? "rGame2"] = rGame2;
global.roomMap[? "rGame3"] = rGame3;

//按键相关
global.keyEnter = ord("C");
global.keyCancel = ord("X");
global.keyMenu = vk_escape;
global.keyLeft = vk_left;
global.keyRight = vk_right;
global.keyJump = ord("Z");

//字体相关
global.fonts = {
	def : draw_get_font(),
	title : font_add("msyh.ttf", 24, true, false, 32, 128)
};

//调试相关
#macro DEBUG true
global.dbgTextVisible = false;
global.specVisible = false;
global.gridVisible = false;
global.debugMenu = noone;

room_goto(rTitle);
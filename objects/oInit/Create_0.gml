//存档相关
global.save = {
	index : 0,
	deathCount : 0,
	exitCount : 0
};
if(directory_exists("saves")) {
	var index = 1, maxVaildIndex = 0;
	var fileName = "saves/" + string(index);
	while(file_exists(fileName)) {
		var file = file_text_open_read(fileName);
		if(!file_text_eof(file))
			maxVaildIndex = index;
		file_text_close(file);
		index++;
		fileName = "saves/" + string(index);
	}
	for(var i = maxVaildIndex + 1; i < index; i++)
		file_delete("saves/" + string(i));
}

//room相关
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
#macro DEBUG debug_mode
global.dbgTextVisible = false;
global.specVisible = false;
global.gridVisible = false;
global.debugMenu = noone;

room_goto(rTitle);
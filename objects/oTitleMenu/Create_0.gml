event_inherited();

//设置相关属性
font = global.fonts.title;
lockY = getViewH(0) / 2;
halign = fa_center;
valign = fa_top;
closeable = false;

aph = 1;

function beforeDrawTabs() {
	//设置文字对齐方式
	draw_set_halign(halign);
	draw_set_valign(valign);
	useFont();	//设置字体
	draw_set_alpha(aph);	//设置透明度
}
function afterDrawTabs() {
	draw_set_alpha(1);	//还原透明度
	resetFont();	//还原字体
	//还原文字对齐方式
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
function drawEvent() {
	if(aph > 0)
		drawTabs(x, y - 50 * (1 - aph));
}

function fnStart(_oid) {
	instance_create_layer(_oid.x, _oid.y, "System", oSaveMenu);
	/*
	//新建实例
	_oid.useFont();
	var oid = instance_create_layer(
		getMenuChildX(_oid), getMenuChildY(_oid, _oid.curIndex),
		"System", oMenu
		);
	_oid.resetFont();
	//设置相关属性
	oid.font = global.fonts.title;
	oid.lockY = getViewH(0) * 0.6;
	oid.halign = fa_left;
	oid.valign = fa_top;
	oid.yOffset = 40;
	//得到已有存档
	var index = (DEBUG && file_exists("saves/0") ? 0 : 1);
	if(directory_exists("saves")) {
		var fileName = "saves/" + string(index);
		//var _map = ds_map_create();
		while(file_exists(fileName)) {
			//dfr = new DotFileReader(_fileName);
			//dfr.fileOpen();
			//transToMap(dfr.readLine(), _map);
			//dfr.fileClose();
			//delete dfr;
			oid.addTab(new oid.Tab(index, load, index));
			index++;
			fileName = "saves/" + string(index);
		}
		//ds_map_destroy(_map);
	}
	function fnNew(index) {
		global.save.index = index;
		room_goto(rGame);
	}
	oid.addTab(new oid.Tab("New", fnNew, index));*/
}
//添加tab
addTab(new Tab("Start", fnStart, id));
addTab(new Tab("Exit", game_end, undefined));
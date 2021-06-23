event_inherited();

//设置相关属性
font = global.titleFont;
lockY = scrViewH(0) / 2;
halign = fa_left;
valign = fa_top;
closeable = false;
function fnStart(_oid) {
	//新建实例
	_oid.useFont();
	var oid = instance_create_layer(
		scrGetMenuChildX(_oid), scrGetMenuChildY(_oid, _oid.curIndex),
		"System", oMenu
		);
	_oid.resetFont();
	//设置相关属性
	oid.font = global.titleFont;
	oid.lockY = scrViewH(0) * 0.6;
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
	oid.addTab(new oid.Tab("New", fnNew, index));
}
//添加tab
addTab(new Tab("Start", fnStart, id));
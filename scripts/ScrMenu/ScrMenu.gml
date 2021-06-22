function scrGetMenuChildX(_oid) { return _oid.x + _oid.maxWidth() * _oid.scale + 20; }
function scrGetMenuChildY(_oid, _index) { return _oid.y + _oid.tabY(_index); }

function scrCreateDebugMenu(_x, _y) {
	//新建实例
	var oid = instance_create_layer(_x, _y, "System", oMenu);
	//设置相关属性
	oid.persistent = true;
	oid.lockY = scrViewH(0) / 2;
	oid.halign = fa_left;
	oid.yOffset = scrViewH(0);
	function fnMove() {	
		//用于将玩家移动至鼠标位置
		if(instance_exists(oPlayer_Active)) {
			oPlayer_Active.x = mouse_x;
			oPlayer_Active.y = mouse_y;
		}
	}
	function fnRetry() {	//用于重试
		if(instance_exists(oPlayer_Active))
			oPlayer_Active.kill();
	}
	function fnSave(_oid) {		//存档相关
		//新建实例
		var oid = instance_create_layer(
			scrGetMenuChildX(_oid), scrGetMenuChildY(_oid, _oid.curIndex),
			"System", oMenu
			);
		//设置相关属性
		oid.persistent = true;
		oid.halign = fa_left;
		oid.yOffset = 40;
		function fnResetSavePoint() {
			if(instance_exists(oPlayer_Active))
				oPlayer_Active.findNearestSavePoint();
		}
		function fnSetSavePointHere() {
			if(instance_exists(oPlayer_Active)) {
				oPlayer_Active.savePointX = oPlayer_Active.x;
				oPlayer_Active.savePointY = oPlayer_Active.y;
			}
		}
		//添加tab
		oid.addTab(new oid.Tab("Reset savepoint to nearest", fnResetSavePoint));
		oid.addTab(new oid.Tab("Set savepoint here", fnSetSavePointHere));
		oid.addTab(new oid.Tab("Save to file", save, global.saveIndex));
	}
	function fnRoomSpd(_oid) {	//调整room_speed的菜单
		//新建实例
		var oid = instance_create_layer(
			scrGetMenuChildX(_oid), scrGetMenuChildY(_oid, _oid.curIndex), 
			"System", oMenu
			);
		//设置相关属性
		oid.persistent = true;
		oid.halign = fa_left;
		function fnSetRoomSpd(_speed) { room_speed = _speed; }	//用于设置房间速度
		//添加tab
		oid.addTab(new oid.Tab("20", fnSetRoomSpd, 20));
		oid.addTab(new oid.Tab("60", fnSetRoomSpd, 60));
		oid.addTab(new oid.Tab("90", fnSetRoomSpd, 90));
		oid.setCurIndex(1);
	}
	function fnVisible(_oid) {	//控制相关内容可视性
		//新建实例
		var oid = instance_create_layer(
			scrGetMenuChildX(_oid), scrGetMenuChildY(_oid, _oid.curIndex), 
			"System", oMenu
			);
		//设置相关属性
		oid.persistent = true;
		oid.halign = fa_left;
		oid.yOffset = 40;
		//添加tab
		oid.addTab(new oid.Tab("DebugText", function() { global.dbgTextVisible = !global.dbgTextVisible; }));
		oid.addTab(new oid.Tab("System", function() { global.specVisible = !global.specVisible; }));
		oid.addTab(new oid.Tab("Grid", function() { global.gridVisible = !global.gridVisible; }));
	}
	//添加tab
	oid.addTab(new oid.Tab("Move", fnMove));
	oid.addTab(new oid.Tab("Retry", fnRetry));
	oid.addTab(new oid.Tab("Save -", fnSave, oid));
	oid.addTab(new oid.Tab("RoomSpd -", fnRoomSpd, oid));
	oid.addTab(new oid.Tab("Visible -", fnVisible, oid));
	return oid;
}

function scrCreateTitleMenu(_x, _y) {
	//新建实例
	var oid = instance_create_layer(_x, _y, "System", oMenu);
	//设置相关属性
	oid.font = global.titleFont;
	oid.lockY = scrViewH(0) / 2;
	oid.halign = fa_left;
	oid.valign = fa_top;
	oid.closeable = false;
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
			global.saveIndex = index;
			room_goto(rGame);
		}
		oid.addTab(new oid.Tab("New", fnNew, index));
	}
	//添加tab
	oid.addTab(new oid.Tab("Start", fnStart, oid));
	return oid;
}
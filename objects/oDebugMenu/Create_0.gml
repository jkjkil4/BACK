event_inherited();

//设置相关属性
lockY = getViewH(0) / 2;
halign = fa_left;
yOffset = getViewH(0);
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
		getMenuChildX(_oid), getMenuChildY(_oid, _oid.curIndex),
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
	oid.addTab(new oid.Tab("Save to file", save, global.save.index));
}
function fnRoomSpd(_oid) {	//调整room_speed的菜单
	//新建实例
	var oid = instance_create_layer(
		getMenuChildX(_oid), getMenuChildY(_oid, _oid.curIndex), 
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
		getMenuChildX(_oid), getMenuChildY(_oid, _oid.curIndex), 
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
addTab(new Tab("Move", fnMove, undefined));
addTab(new Tab("Retry", fnRetry, undefined));
addTab(new Tab("Save -", fnSave, id));
addTab(new Tab("RoomSpd -", fnRoomSpd, id));
addTab(new Tab("Visible -", fnVisible, id));

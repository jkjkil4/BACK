event_inherited();

function Tab_SaveMenu(_vaild, _index) constructor {
	vaild = _vaild
	index = _index
	if(vaild) {
		var map = ds_map_create();
	
		var dfr = new DotFileReader("saves/" + string(index));
		dfr.fileOpen();
		transToMap(dfr.readLine(), map);
		dfr.fileClose();
		delete dfr;
	
		deathCount = (ds_map_exists(map, "DeathC") ? map[? "DeathC"] : 0);
		exitCount = (ds_map_exists(map, "ExitC") ? map[? "ExitC"] : 0);

		ds_map_destroy(map);
	}
}

function tabWidth(_tab, _selected) { return sprite_get_width(sSaveTab); }
function tabHeight(_tab, _selected) { return sprite_get_height(sSaveTab); }

function drawTab(_tab, _x, _y, _focused, _selected) {
	draw_sprite(sSaveTab, _selected, _x, _y);
}

/*
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
	
lockY = getViewH(0) / 2;
yOffset = 40;
spacing = 20;
//得到已有存档
var index = (DEBUG && file_exists("saves/0") ? 0 : 1);
if(directory_exists("saves")) {
	var fileName = "saves/" + string(index);
	while(file_exists(fileName)) {
		
		addTab(new Tab_SaveMenu(true, index));
		index++;
		fileName = "saves/" + string(index);
	}
}

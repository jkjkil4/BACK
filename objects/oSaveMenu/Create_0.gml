event_inherited();

enum SaveTabSelect { Continue, Rename, Delete };
select = -1;

#macro SAVETAB_TXTSPACING 8

function menuLogic() {
	if(ds_list_size(tabList) != 0) {
		if(select == -1) {
			checkUD();
		} else {
			if(keyboard_check_pressed(global.keyLeft))
				select--;
			if(keyboard_check_pressed(global.keyRight))
				select++;
			if(select < 0)
				select = SaveTabSelect.Delete;
			else if(select > SaveTabSelect.Delete)
				select = SaveTabSelect.Continue;
		}
		
		if(isEnter()) {
			if(select == -1) {
				select = SaveTabSelect.Continue;
			} else {
				switch(select) {
				case SaveTabSelect.Continue:
				case SaveTabSelect.Rename:
					show_message("还没做");
					break;
				case SaveTabSelect.Delete:
					var oid = instance_create_layer(0, 0, "System", oDialog);
					oid.text = "Do you want to delete it?";
					oid.onAccept = function(_index) {
						fileClear("saves/" + string(curIndex));
						with(oSaveMenu) {
							var count = ds_list_size(tabList);
							for(var i = 0; i < count; i++) {
								var tab = tabList[| i];
								if(tab.index == _index)
									tab.vaild = false;
							}
							select = -1;
						}
					}
					oid.acceptArgs = curIndex;
					break;
				}
			}
		}
	}
	
	if(closeable && isCancel()) {
		if(select == -1) {
			closeLater();
		} else select = -1;
	}
}
function drawEvent() {
	if(global.sys.focusedWidget() == id)
		drawTabs(x, y);
}

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

function tabWidth(_tab) { return sprite_get_width(sSaveTab); }
function tabHeight(_tab) { return sprite_get_height(sSaveTab); }

function drawTab(_index, _tab, _x, _y) {
	var isSelected = (curIndex == _index);
	if(select != -1 && !isSelected)
		draw_set_alpha(0.5);
	
	draw_sprite(sSaveTab, isSelected, _x, _y);
	
	if(_tab.vaild) {
		var sprWidth = sprite_get_width(sSaveTab), sprHeight = sprite_get_height(sSaveTab);
		var bottom = _y + sprHeight - SAVETAB_TXTSPACING;
		var xOffset = sprWidth / 2 - SAVETAB_TXTSPACING;

		if(select != -1 && isSelected) {
			draw_set_valign(fa_bottom);
			draw_set_halign(fa_right);
			draw_set_color(global.colors.drakGray);
			draw_text(_x + xOffset, bottom + 2, "Delete");
			draw_set_color(select == 2 ? c_yellow : global.colors.lightGray);
			draw_text(_x + xOffset, bottom, "Delete");
		
			draw_set_halign(fa_center);
			draw_set_color(global.colors.drakGray);
			draw_text(_x, bottom + 2, "Rename");
			draw_set_color(select == 1 ? c_yellow : global.colors.lightGray);
			draw_text(_x, bottom, "Rename");
		
			draw_set_halign(fa_left);
			draw_set_color(global.colors.drakGray);
			draw_text(_x - xOffset, bottom + 2, "Continue");
			draw_set_color(select == 0 ? c_yellow : global.colors.lightGray);
			draw_text(_x - xOffset, bottom, "Continue");
		}
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_font(global.fonts.title);
		draw_set_color(global.colors.txtBg);
		draw_text(_x - xOffset, _y + SAVETAB_TXTSPACING + 2, "114514");
		draw_set_color(global.colors.lightGray);
		draw_text(_x - xOffset, _y + SAVETAB_TXTSPACING, "114514");
		
		draw_set_font(global.fonts.def);
		draw_set_color(c_white);
	}
	
	if(select != -1 && !isSelected)
		draw_set_alpha(1);
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
		addTab(new Tab_SaveMenu(!fileIsEmpty(fileName), index));
		index++;
		fileName = "saves/" + string(index);
	}
}

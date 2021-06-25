event_inherited();

enum SaveTabSelect { Continue, Rename, Delete };
select = -1;

#macro SAVETAB_TXTSPACING 10

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
				if(tabList[| curIndex].vaild) {
					select = SaveTabSelect.Continue;
				} else {
					global.save.index = curIndex;
					room_goto(rGame);
				}
			} else {
				switch(select) {
				case SaveTabSelect.Continue:
					load(curIndex);
					break;
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
			function labelColor(_index) { return select == _index ? c_yellow : global.colors.lightGray; }
			
			draw_set_valign(fa_bottom);
			draw_set_halign(fa_right);
			drawTextEx(_x + xOffset, bottom, "Delete", labelColor(2), global.colors.darkGray);
		
			draw_set_halign(fa_center);
			drawTextEx(_x, bottom, "Rename", labelColor(1), global.colors.darkGray);

			draw_set_halign(fa_left);
			drawTextEx(_x - xOffset, bottom, "Continue", labelColor(0), global.colors.darkGray);
		}
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_font(global.fonts.title);
		drawTextEx(_x - xOffset, _y + SAVETAB_TXTSPACING, "114514", global.colors.lightGray, global.colors.txtBg);
		draw_set_font(global.fonts.def);
	} else {
		draw_set_font(global.fonts.lightLarge);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		var yy = _y + sprite_get_height(sSaveTab) / 2;
		drawTextEx(_x, yy, "Start", isSelected ? c_yellow : global.colors.lightGray, global.colors.darkGray);
		
		draw_set_font(global.fonts.def);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
	
	if(select != -1 && !isSelected)
		draw_set_alpha(1);
}

	
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
addTab(new Tab_SaveMenu(false, 0));

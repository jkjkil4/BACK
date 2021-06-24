function fileIsEmpty() {
	
}

function DotFileWriter(_file) constructor {
	file = _file;
	static fileOpen = function() { handle = file_text_open_write(file); }
	static write = function() {
		for(var i = 0; i < argument_count; i++) {
			file_text_write_string(
				handle, 
				string_replace_all(string_replace_all(argument[i], "\\", "\\\\"), ",", "\\,")
				);
			file_text_write_string(handle, ",");
		}
	}
	static nextLine = function() { file_text_writeln(handle); }
	static fileClose = function() { file_text_close(handle); }
}

function DotFileReader(_file) constructor {
	file = _file;
	static fileOpen = function() { handle = file_text_open_read(file); }
	static readLine = function() {
		var line = file_text_readln(handle);
		var len = string_length(line);
		var buf = "";
		var result = [];
		var count = 0;
		for(var i = 0; i < len; i++) {
			var ch = string_char_at(line, i + 1);	// i
			if(ch == "\\" && i != len - 1) {
				buf += string_char_at(line, i + 2);	// i + 1
				i++;
			} else if(ch == ",") {
				result[count] = buf;
				buf = "";
				count++;
			} else buf += ch;
		}
		return result;
	}
	static nextLine = function() { return file_text_readln(handle); }
	//static atEnd = function() { return file_text_eof(handle); }
	static fileClose = function() { file_text_close(handle); }
}

function transToMap(_dfArray, _dsMap) {
	ds_map_clear(_dsMap);
	var len = array_length(_dfArray);
	for(var i = 0; i < len - 1; i += 2)
		_dsMap[? _dfArray[i]] = _dfArray[i + 1];
}

function save(_index) {
	if(instance_exists(oPlayer_Active)) {
		if(!directory_exists("saves"))
			directory_create("saves");
		var dfw = new DotFileWriter("saves/" + string(global.save.index));
		dfw.fileOpen();
		dfw.write("DeathC", global.save.deathCount);
		dfw.write("ExitC", global.save.exitCount);
		dfw.nextLine();
		dfw.write("rn", room_get_name(room));
		dfw.write("spx", oPlayer_Active.savePointX);
		dfw.write("spy", oPlayer_Active.savePointY);
		dfw.fileClose();
		delete dfw;
	}
}
function load(_index) {
	var fileName = "saves/" + string(_index);
	if(file_exists(fileName)) {
		//创建map
		var mapBaseInfo = ds_map_create(), mapImpInfo = ds_map_create();
		
		//读取
		var dfr = new DotFileReader(fileName);
		dfr.fileOpen();
		transToMap(dfr.readLine(), mapBaseInfo);
		transToMap(dfr.readLine(), mapImpInfo);
		dfr.fileClose();
		delete dfr;
		
		//mapBaseInfo
		global.save.deathCount = (ds_map_exists(mapBaseInfo, "DeathC") ? real(mapBaseInfo[? "DeathC"]) : 0);
		global.save.exitCount = (ds_map_exists(mapBaseInfo, "ExitC") ? real(mapBaseInfo[? "ExitC"]) : 0);
		
		//mapImpInfo
		if(!ds_map_exists(mapImpInfo, "spx") || !ds_map_exists(mapImpInfo, "spy") || !ds_map_exists(mapImpInfo, "rn")) {
			show_message("Failed to load (variable does not exist)");	
			return;
		}
		var rn = mapImpInfo[? "rn"];
		if(!ds_map_exists(global.roomMap, rn)) {
			show_message("Failed to load (room does not exist)");
			return;
		}
		var spx = real(mapImpInfo[? "spx"]), spy = real(mapImpInfo[? "spy"]);
		var player = instance_create_layer(spx, spy, "Entity", oPlayer_Tmp);
		player.savePointX = spx;
		player.savePointY = spy;
		room_goto(global.roomMap[? rn]);
		
		//销毁map
		ds_map_destroy(mapBaseInfo);
		ds_map_destroy(mapImpInfo);
		
		global.save.index = _index;
	}
}
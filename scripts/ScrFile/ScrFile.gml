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
	static atEnd = function() { return file_text_eof(handle); }
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
		var dfw = new DotFileWriter("saves/" + string(global.saveIndex));
		dfw.fileOpen();
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
		var map = ds_map_create();
		var dfr = new DotFileReader(fileName);
		dfr.fileOpen();
		dfr.nextLine();
		transToMap(dfr.readLine(), map);
		dfr.fileClose();
		delete dfr;
		if(!ds_map_exists(map, "spx") || !ds_map_exists(map, "spy") || !ds_map_exists(map, "rn")) {
			show_message("Failed to load (variable does not exist)");	
			return;
		}
		var rn = map[? "rn"];
		if(!ds_map_exists(global.roomMap, rn)) {
			show_message("Failed to load (room does not exist)");
			return;
		}
		var spx = real(map[? "spx"]), spy = real(map[? "spy"]);
		var player = instance_create_layer(spx, spy, "Entity", oPlayer_Tmp);
		player.savePointX = spx;
		player.savePointY = spy;
		room_goto(global.roomMap[? rn]);
		ds_map_destroy(map);
		global.saveIndex = _index;
	}
}
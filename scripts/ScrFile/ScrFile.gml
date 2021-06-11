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
		var _line = file_text_readln(handle);
		var _len = string_length(_line);
		var _buf = "";
		var _result = [];
		var _count = 0;
		for(var i = 0; i < _len; i++) {
			var _ch = string_char_at(_line, i + 1);	// i
			if(_ch == "\\" && i != _len - 1) {
				_buf += string_char_at(_line, i + 2);	// i + 1
				i++;
			} else if(_ch == ",") {
				_result[_count] = _buf;
				_buf = "";
				_count++;
			} else _buf += _ch;
		}
		return _result;
	}
	static nextLine = function() { return file_text_readln(handle); }
	static atEnd = function() { return file_text_eof(handle); }
	static fileClose = function() { file_text_close(handle); }
}

function transToMap(_dfArray, _dsMap) {
	ds_map_clear(_dsMap);
	var _len = array_length(_dfArray);
	for(var i = 0; i < _len - 1; i += 2)
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
	var _fileName = "saves/" + string(_index);
	if(file_exists(_fileName)) {
		var _map = ds_map_create();
		var dfr = new DotFileReader(_fileName);
		dfr.fileOpen();
		dfr.nextLine();
		transToMap(dfr.readLine(), _map);
		dfr.fileClose();
		delete dfr;
		if(!ds_map_exists(_map, "spx") || !ds_map_exists(_map, "spy") || !ds_map_exists(_map, "rn")) {
			show_message("Failed to load (variable does not exist)");	
			return;
		}
		var rn = _map[? "rn"];
		if(!ds_map_exists(global.roomMap, rn)) {
			show_message("Failed to load (room does not exist)");
			return;
		}
		var spx = real(_map[? "spx"]), spy = real(_map[? "spy"]);
		var player = instance_create_layer(spx, spy, "Entity", oPlayer_Tmp);
		player.savePointX = spx;
		player.savePointY = spy;
		room_goto(global.roomMap[? rn]);
		ds_map_destroy(_map);
		global.saveIndex = _index;
	}
}
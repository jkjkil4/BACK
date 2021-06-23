t += 0.4;

if(keyboard_check_pressed(vk_space)) {
	var f = file_text_open_write("eff_title_elems.txt");
	file_text_write_string(f, "elements = [");
	var len = array_length(elements);
	var hasPrev = false;
	for(var i = 0; i < len; i++) {
		if(hasPrev) {
			file_text_write_string(f, ",");	
		} else hasPrev = true;
		
		var element = elements[i];
		file_text_write_string(f, "\n    [" + string(element[0]) + ", " + string(element[1])
			+ ", " + string(element[2]) + ", " + string(element[3]) + "]");
	}
	file_text_write_string(f, "\n];");
	file_text_close(f);
}
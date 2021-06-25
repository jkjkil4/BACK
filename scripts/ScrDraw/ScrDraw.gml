function drawTextEx(_x, _y, _text, _fgColor, _bgColor) {
	draw_set_color(_bgColor);
	draw_text(_x, _y + 2, _text);
	draw_set_color(_fgColor);
	draw_text(_x, _y, _text);
	draw_set_color(c_white);
}
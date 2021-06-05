event_inherited();

halign = fa_center;
valign = fa_middle;
spacing = 8;
scale = 1;
lockY = scrViewH(0) / 2;

yOffsetTo = 0;
yOffset = 0;
function updateYOffsetTo() {	//根据当前tab位置设置yOffset
	var height = string_height("A") * scale;
	var yy = y + (height + spacing) * curIndex;
	yOffsetTo = min(0, max(y, lockY) - yy);
}

function Tab(_text, _fn) constructor {
	text = _text;
	fn = _fn;
}
tabList = ds_list_create();
curIndex = 0;

function addTab(_tab) {	//添加tab
	ds_list_add(tabList, _tab);
}

function drawTab() {	//绘制tab
	var _size = ds_list_size(tabList);
	if(_size == 0)
		return;
	draw_set_halign(halign);
	draw_set_valign(valign);
	var _viewH = scrViewH(0);
	var _height = string_height("A");
	var _yy = y + yOffset;
	var _normalYDelta = _height * scale + spacing;
	var _start = 0;
	if(_yy < 0) {
		_start = floor(-_yy / _normalYDelta);
		_yy += _start * _normalYDelta;
	}
	for(var i = _start; i < _size; i++) {
		var _tab = tabList[| i];
		var _isCurrent = (i == curIndex);
		var _color = (_isCurrent ? c_yellow : c_white);
		var _scale = (_isCurrent ? scale * 1.1 : scale);
		draw_text_transformed_color(x, _yy, _tab.text, _scale, _scale, 0, _color, _color, _color, _color, 1);
		_yy += _height * _scale + spacing;
		if(_yy > _viewH + _height)
			break;
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
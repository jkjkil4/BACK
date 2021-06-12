event_inherited();

halign = fa_center;
valign = fa_middle;
spacing = 8;
scale = 1;
lockY = y;
closeable = true;

font = -1;
function useFont() {
	if(font != -1)
		draw_set_font(font);
}
function resetFont() { draw_set_font(global.defaultFont); }

yOffsetTo = 0;
yOffset = 0;
function updateYOffsetTo() {	//根据当前tab位置设置yOffsetTo
	useFont();
	yOffsetTo = min(0, max(y, lockY) - (y + tabY(curIndex)));
	resetFont();
}
function setCurIndex(_index) {	//设置当前tab
	curIndex = _index;
	updateYOffsetTo();
}

function Tab(_text, _fn, _args) constructor {
	text = _text;
	fn = _fn;
	args = _args;
}
tabList = ds_list_create();
curIndex = 0;

function addTab(_tab) {	//添加tab
	ds_list_add(tabList, _tab);
}

function tabY(_index) {
	var _y = 0;
	for(var i = 0; i < _index; i++) {
		_y += tabHeight(tabList[| i], i == curIndex) + spacing;
	}
	return _y;
}
function tabWidth(_tab, _selected) {
	return string_width(_tab.text) * (_selected ? scale * 1.1 : scale);
}
function tabHeight(_tab, _selected) {
	return string_height("A") * (_selected ? scale * 1.1 : scale);
}
function maxWidth() {
	var _size = ds_list_size(tabList);
	var _max = 0;
	for(var i = 0; i < _size; i++) {
		var _width = tabWidth(tabList[| i], i == curIndex);
		if(_width > _max)
			_max = _width;
	}
	return _max;
}

function beforeDrawTabs() {
	//设置文字对齐方式
	draw_set_halign(halign);
	draw_set_valign(valign);
	//设置字体
	useFont();
}
function afterDrawTabs() {
	//还原字体
	resetFont();
	//还原文字对齐方式
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
function drawTab(_tab, _x, _y, _focused, _selected) {	//绘制单个tab
	var _color = (_focused ? (_selected ? c_yellow : c_white) 
						   : (_selected ? make_color_rgb(200, 200, 0) : make_color_rgb(200, 200, 200)));
	var _scale = (_selected ? scale * 1.1 : scale);
	draw_text_transformed_color(_x, _y, _tab.text, _scale, _scale, 0, _color, _color, _color, _color, 1);
}
function drawTabs(_xx, _yy) {	//绘制所有tab
	var _size = ds_list_size(tabList);
	if(_size == 0)	//如果tab数量不足，则return
		return;
	var _isFocused = (global.sys.focusedWidget() == id);	//得到是否为焦点
	
	var _viewH = scrViewH(0);	//视野高度
	var _start = 0;	//起始index
	var _y = _yy + yOffset;	//起始y
	beforeDrawTabs();	//绘制前
	var _nextOffset = tabHeight(tabList[| 0], curIndex == 0) + spacing;
	while(_y + _nextOffset < 0) {		//根据情况修改_start和_y，节省开销
		_y += _nextOffset;
		_start++;
		_nextOffset = tabHeight(tabList[| _start], _start == curIndex) + spacing;
	}
	for(var i = _start; i < _size; i++) {	//遍历进行绘制
		var _tab = tabList[| i];	//当前tab
		var _isCurrent = (i == curIndex);	//该tab是否选中
		drawTab(_tab, _xx, _y, _isFocused, _isCurrent);	//绘制
		_y += tabHeight(_tab, _isCurrent) + spacing;	//将_y设置为下一个tab的位置
		if(_y > _viewH)	//判断超出视野时停止
			break;
	}
	afterDrawTabs();	//绘制后
}

function drawEvent() {
	drawTabs(x, y);
}

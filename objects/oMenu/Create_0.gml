event_inherited();

halign = fa_center;
valign = fa_middle;
spacing = 8;
scale = 1;
lockY = y;
closeable = true;

function isUp() { return keyboard_check_pressed(vk_up); }
function isDown() { return keyboard_check_pressed(vk_down); }
function isEnter() { return keyboard_check_pressed(global.keyEnter); }
function isCancel() { return keyboard_check_pressed(global.keyCancel); }

function checkUD() {
	var size = ds_list_size(tabList);
	var tmpCurIndex = curIndex;
		
	//根据按键改变tmpCurIndex
	if(isUp()) tmpCurIndex--;
	if(isDown()) tmpCurIndex++;
	
	//限制tmpCurIndex
	if(tmpCurIndex < 0)
		tmpCurIndex = size - 1;
	else if(tmpCurIndex >= size)
		tmpCurIndex = 0;
	
	//更新curIndex
	if(tmpCurIndex != curIndex) {
		curIndex = tmpCurIndex;
		updateYOffsetTo();
	}
}
function menuLogic() {
	if(ds_list_size(tabList) != 0) {
		checkUD();

		//按下确认键时触发
		if(isEnter()) {
			var tab = tabList[| curIndex];
			if(tab.args == undefined) {
				tab.fn()
			} else tab.fn(tab.args);
		}
	}
	
	//按下取消键时关闭
	if(closeable && isCancel())
		close();
}


font = -1;
function useFont() {
	if(font != -1)
		draw_set_font(font);
}
function resetFont() { draw_set_font(global.fonts.def); }

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
	var yy = 0;
	for(var i = 0; i < _index; i++) {
		yy += tabHeight(tabList[| i], i == curIndex) + spacing;
	}
	return yy;
}
function tabWidth(_tab, _selected) {
	return string_width(_tab.text) * scale;
}
function tabHeight(_tab, _selected) {
	return string_height(_tab.text) * scale;
}
function maxWidth() {
	var size = ds_list_size(tabList);
	var maxw = 0;
	for(var i = 0; i < size; i++) {
		var width = tabWidth(tabList[| i], i == curIndex);
		if(width > maxw)
			maxw = width;
	}
	return maxw;
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
	var color = (_focused ? (_selected ? c_yellow : c_white) 
						   : (_selected ? make_color_rgb(200, 200, 0) : make_color_rgb(200, 200, 200)));
	draw_set_color(global.colorTxtBg);
	draw_text_transformed(_x, _y + 2, _tab.text, scale, scale, 0);
	draw_set_color(color);
	draw_text_transformed(_x, _y, _tab.text, scale, scale, 0);
	draw_set_color(c_white);
}
function drawTabs(_xx, _yy) {	//绘制所有tab
	var size = ds_list_size(tabList);
	if(size == 0)	//如果tab数量不足，则return
		return;
	var isFocused = (global.sys.focusedWidget() == id);	//得到是否为焦点
	
	var viewH = getViewH(0);	//视野高度
	var start = 0;	//起始index
	var yy = _yy + yOffset;	//起始y
	beforeDrawTabs();	//绘制前
	var nextOffset = tabHeight(tabList[| 0], curIndex == 0) + spacing;
	while(yy + nextOffset < 0) {		//根据情况修改_start和_y，节省开销
		yy += nextOffset;
		start++;
		nextOffset = tabHeight(tabList[| start], start == curIndex) + spacing;
	}
	for(var i = start; i < size; i++) {	//遍历进行绘制
		var tab = tabList[| i];	//当前tab
		var isCurrent = (i == curIndex);	//该tab是否选中
		drawTab(tab, _xx, yy, isFocused, isCurrent);	//绘制
		yy += tabHeight(tab, isCurrent) + spacing;	//将_y设置为下一个tab的位置
		if(yy > viewH)	//判断超出视野时停止
			break;
	}
	afterDrawTabs();	//绘制后
}

function drawEvent() {
	drawTabs(x, y);
}

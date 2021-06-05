global.sys = id;

widgetList = ds_list_create();

function focusedWidget() {
	var _size = ds_list_size(widgetList);
	if(_size == 0)
		return noone;
	return widgetList[| _size - 1];
}
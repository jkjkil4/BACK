global.sys = id;

widgetList = ds_list_create();
debugMenu = noone;

function focusedWidget() {
	var size = ds_list_size(widgetList);
	if(size == 0)
		return noone;
	return widgetList[| size - 1];
}
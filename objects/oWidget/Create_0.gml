ds_list_add(global.sys.widgetList, id);

function drawEvent() {}
function closeEvent() {}

function close() {
	closeEvent();
	instance_destroy(); 
}
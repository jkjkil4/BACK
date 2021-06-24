ds_list_add(global.sys.widgetList, id);
closeRequested = false;

function drawEvent() {}
function closeEvent() {}

function closeLater() { closeRequested = true; }
function close() {
	closeEvent();
	instance_destroy(); 
}
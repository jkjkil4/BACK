event_inherited();

text = "";
textCancel = "No";
textAccept = "Yes";
accepted = false;

function onAccept() {}
acceptArgs = undefined;

function drawEvent() {
	var xx = getViewW(0) / 2, yy = getViewH(0) / 2;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_font(global.fonts.title);
	drawTextEx(xx, yy - 20, text, global.colors.lightGray, global.colors.txtBg);
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	draw_set_font(global.fonts.def);
	drawTextEx(xx - 20, yy + 20, textCancel, accepted ? global.colors.lightGray : c_yellow, global.colors.darkGray);
	
	draw_set_halign(fa_left);
	drawTextEx(xx + 20, yy + 20, textAccept, accepted ? c_yellow : global.colors.lightGray, global.colors.darkGray);
}
function closeEvent() {
	if(accepted) {
		if(acceptArgs == undefined) {
			onAccept();
		} else onAccept(acceptArgs);
	}
}
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
	draw_set_color(global.colorTxtBg);
	draw_text(xx, yy - 18, text);
	draw_set_color(c_white);
	draw_text(xx, yy - 20, text);
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	draw_set_font(global.fonts.def);
	draw_set_color(c_black);
	draw_text(xx - 20, yy + 22, textCancel);
	draw_set_color(accepted ? c_white : c_yellow);
	draw_text(xx - 20, yy + 20, textCancel);
	
	draw_set_halign(fa_left);
	draw_set_color(c_black);
	draw_text(xx + 20, yy + 22, textAccept);
	draw_set_color(accepted ? c_yellow : c_white);
	draw_text(xx + 20, yy + 20, textAccept);
}
function closeEvent() {
	if(accepted) {
		if(acceptArgs == undefined) {
			onAccept();
		} else onAccept(acceptArgs);
	}
}
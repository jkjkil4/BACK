event_inherited();

function isCancel() { return keyboard_check_pressed(global.keyMenu) || keyboard_check_pressed(global.keyCancel); }

//得到当前画面
surf = surface_create(getViewW(0), getViewH(0));
surface_copy(surf, 0, 0, application_surface);

//停用Entity层的所有实例
layerid = layer_get_id("Entity");
instance_deactivate_layer(layerid);

//相关设定
function drawEvent() {
	if(surface_exists(surf))
		draw_surface(surf, 0, 0);
	draw_set_alpha(0.4);
	draw_set_color(c_black);
	draw_rectangle(0, 0, getViewW(0), getViewH(0), false);
	draw_set_color(c_white);
	draw_set_alpha(1);
	drawTabs(x, y);
}
lockY = getViewH(0) / 2;
halign = fa_center;


function fnRetry(_self) {
	instance_activate_layer(_self.layerid);
	if(instance_exists(oPlayer_Active))
		oPlayer_Active.killLater();
	_self.close();
}
function fnSaveAndExit(_self) {
	instance_activate_layer(_self.layerid);
	global.save.exitCount++;
	save(global.save.index);
	room_goto(rTitle);
}
//添加tab
addTab(new Tab("Continue", close, undefined));
addTab(new Tab("Retry", fnRetry, id));
addTab(new Tab("Save and exit", fnSaveAndExit, id));
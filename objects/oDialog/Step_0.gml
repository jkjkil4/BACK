if(keyboard_check_pressed(global.keyLeft) || keyboard_check_pressed(global.keyRight))
	accepted = !accepted;

if(keyboard_check_pressed(global.keyCancel)) {
	accepted = false;
	closeLater();
} else if(keyboard_check_pressed(global.keyEnter)) {
	keyboard_clear(global.keyEnter);
	closeLater();
}
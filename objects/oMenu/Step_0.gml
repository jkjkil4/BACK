

if(global.sys.focusedWidget() == id)
	menuLogic();


//让yOffset接近yOffsetTo
if(yOffsetTo != yOffset) {
	var delta = yOffsetTo - yOffset;
	var spd = delta / 3;
	if(abs(spd) < 2)
		spd = sign(spd) * 2;
	yOffset = (abs(spd) >= abs(delta) ? yOffsetTo : yOffset + spd);
}
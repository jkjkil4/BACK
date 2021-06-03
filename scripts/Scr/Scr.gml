function scrViewBoundX(_x) {
	var viewW = scrViewW(0);
	return scrBound(0, _x - viewW / 2, room_width - viewW);
}
function scrViewBoundY(_y) {
	var viewH = scrViewH(0);
	return scrBound(0, _y - viewH / 2, room_height - viewH);
}
enum RollDirection { LeftToRight = 0x1, UpToDown = 0x2, All = 0x3/*0x1|0x2*/ };

surf = -1;
function init(_rollDir, _margin) {
	rollDir = _rollDir;
	margin = _margin;
	origWidth = scrViewW(0);
	origHeight = scrViewH(0);
	surfWidth = (rollDir & RollDirection.LeftToRight ? origWidth + 2 * margin : origWidth);
	surfHeight = (rollDir & RollDirection.UpToDown ? origHeight + 2 * margin : origHeight);
	if(surface_exists(surf))
		surface_free(surf);
	surf = surface_create(surfWidth, surfHeight);
}

function lx(_x) { return _x - origWidth * floor(_x / origWidth); }
function ly(_y) { return _y - origHeight * floor(_y / origHeight); }
function tx(_x) { return rollDir & RollDirection.LeftToRight ? _x + margin : _x; }
function ty(_y) { return rollDir & RollDirection.UpToDown ? _y + margin : _y; }

function beforeDraw() {
	if(!surface_exists(surf))
		surf = surface_create(surfWidth, surfHeight);
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
}
function afterDraw(isGui) {
	surface_reset_target();
	var isLr = rollDir & RollDirection.LeftToRight;
	var isUd = rollDir & RollDirection.UpToDown;
	var origX = (isLr ? margin : 0);
	var origY = (isUd ? margin : 0);
	var vx = (isGui ? 0 : scrViewX(0));
	var vy = (isGui ? 0 : scrViewY(0));
	draw_surface_part(surf, origX, origY, origWidth, origHeight, vx, vy);
	if(isLr) {
		draw_surface_part(surf, 0, origY, margin, origHeight, vx + origWidth - margin, vy);
		draw_surface_part(surf, margin + origWidth, origY, margin, origHeight, vx, vy);
	}
	if(isUd) {
		draw_surface_part(surf, origX, 0, origWidth, margin, vx, vy + origHeight - margin);
		draw_surface_part(surf, origX, margin + origHeight, origWidth, margin, vx, vy);
	}
	if(isLr && isUd) {
		draw_surface_part(surf, 0, 0, margin, margin, vx + origWidth - margin, vy + origHeight - margin);
		draw_surface_part(surf, margin + origWidth, margin + origHeight, margin, margin, vx, vy);
		draw_surface_part(surf, margin + origWidth, 0, margin, margin, vx, vy + origHeight - margin);
		draw_surface_part(surf, 0, margin + origHeight, margin, margin, vx + origWidth - margin, vy);
	}
}
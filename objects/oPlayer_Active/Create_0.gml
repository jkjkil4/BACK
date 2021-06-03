#macro XSPD_RAISE 0.4
#macro XSPD_REDUCE -0.4
#macro XSPD_REDUCE_WITH_KEY -0.7
#macro AUTO_UP_HEIGHT 3

grav = 0.3;
xspd = 0;
xspdMax = 5;
yspd = 0;
yspdMax = 8;

jumpTimesMax = 3;
jumpTimes = 0;
jumpSpd = -6;
jumpedOut = false;

function BorderPortalInfo(_toRoomId, _toPortalId, _xOffset, _yOffset) constructor {
	toRoomId = _toRoomId;
	toPortalId = _toPortalId;
	xOffset = _xOffset;
	yOffset = _yOffset;
}

function findNearestSavePoint() {
	var nearestSavePoint = instance_nearest(x, y, oSavePoint);
	savePointX = (nearestSavePoint == noone ? x : nearestSavePoint.x);
	savePointY = (nearestSavePoint == noone ? y : nearestSavePoint.y);
}

function preMoveUp() {
	for(var upOffset = -1; upOffset >= -AUTO_UP_HEIGHT; upOffset--) {
		if(!collision_rectangle(bbox_left + xspd, bbox_top + upOffset, bbox_right + xspd, bbox_bottom + upOffset, oSolid, true, true)) {
			y += upOffset;
			if(yspd > 0)
				yspd = 0;
			break;
		}
	}	
}

#macro XSPD_RAISE 0.4
#macro XSPD_REDUCE -0.4
#macro XSPD_REDUCE_WITH_KEY -0.7
#macro AUTO_UP_HEIGHT 3

//移动相关
grav = 0.3;
xspd = 0;
xspdMax = 5;
yspd = 0;
yspdMax = 8;

//跳跃相关
jumpTimesMax = 3;
jumpTimes = 0;
jumpSpd = -6;
jumpedOut = false;

//在过面时使用
function BorderPortalInfo(_id, _borderPortalId) constructor {
	//传送相关
	toRoomId = _borderPortalId.toRoomId;
	toPortalId = _borderPortalId.toPortalId;
	//玩家相对于传送门的坐标
	xOffset = _id.x - _borderPortalId.x;
	yOffset = _id.y - _borderPortalId.y;
	//上一步的玩家相对于传送门的坐标，用于解决过面时玩家被“撕裂”的bug
	xprevOffset = _id.xprevious - _borderPortalId.x;
	yprevOffset = _id.yprevious - _borderPortalId.y;
	//surface绘制位置相对于传送门的坐标
	surfXOffset = getViewX(0) - _borderPortalId.x;
	surfYOffset = getViewY(0) - _borderPortalId.y;
}

//找离当前位置最近的存档点，若没有则设定为当前位置
function findNearestSavePoint() {
	var nearestSavePoint = instance_nearest(x, y, oSavePoint);	//找最近的存档点
	savePointX = (nearestSavePoint == noone ? x : nearestSavePoint.x);
	savePointY = (nearestSavePoint == noone ? y : nearestSavePoint.y);
}

//判定死亡
function kill() { instance_change(oPlayer_Dead, true); }
function killLater() { alarm[1] = 1; }

//自动上坡
function preMoveUp() {
	for(var upOffset = -1; upOffset >= -AUTO_UP_HEIGHT; upOffset--) {
		if(!collision_rectangle(bbox_left + xspd, bbox_top + upOffset, bbox_right + xspd, bbox_bottom + upOffset, oSolid, true, true)) {
			y += upOffset;
			if(yspd > 0)	//如果有向下的速度则将其设置为0
				yspd = 0;
			break;
		}
	}	
}

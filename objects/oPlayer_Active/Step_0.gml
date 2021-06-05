//左右键的判断
var keyRight = keyboard_check(global.keyRight);
var keyLeft = keyboard_check(global.keyLeft);
var keyRightLeft = keyRight - keyLeft;

if(xspd == 0) {
	xspd += keyRightLeft * XSPD_RAISE;
} else {
	var xspdSign = sign(xspd);	//xspd的符号
	//根据按键情况决定xspd变化量
	var xspdChange = (keyRightLeft == 0
					 ? XSPD_REDUCE
					 : (xspdSign == keyRightLeft ? XSPD_RAISE : XSPD_REDUCE_WITH_KEY));
	xspd += xspdSign * xspdChange;	//改变xspd
	if(sign(xspd) != xspdSign) {	//xspd符号改变时将其设置为0
		xspd = 0;
	} else if(abs(xspd) > xspdMax) {	//限制xspd
		xspd = xspdSign * xspdMax;
	}
}
if(abs(xspd) < 0.001)	//避免精度问题
	xspd = 0;
if(xspd > 0) {	//向右移动
	var right = bbox_right + xspd;
	//进入自动上坡的判定范围时，进行尝试
	if(collision_line(right, bbox_bottom - AUTO_UP_HEIGHT, right, bbox_bottom, oSolid, true, true))
		preMoveUp();
	//判断即将移动到的位置是否和oSolid碰撞，如果碰撞则吸附
	if(collision_line(right, bbox_top, right, bbox_bottom, oSolid, true, true)) {
		for(var xoffset = xspd - 1; xoffset > 0; xoffset--) {
			if(!collision_line(bbox_right + xoffset, bbox_top, bbox_right + xoffset, bbox_bottom - AUTO_UP_HEIGHT, oSolid, true, true))	{
				x += xoffset;
				break;
			}
		}
		xspd = 0;
	} else x += xspd;
} else if(xspd < 0) {	//向左移动
	var left = bbox_left + xspd;
	//进入自动上坡的判定范围时，进行尝试
	if(collision_line(left, bbox_bottom - AUTO_UP_HEIGHT, left, bbox_bottom, oSolid, true, true))
		preMoveUp();
	//判断即将移动到的位置是否和oSolid碰撞，如果碰撞则吸附
	if(collision_line(left, bbox_top, left, bbox_bottom, oSolid, true, true)) {
		for(var xoffset = xspd + 1; xoffset < 0; xoffset++) {
			if(!collision_line(bbox_left + xoffset, bbox_top, bbox_left + xoffset, bbox_bottom - AUTO_UP_HEIGHT, oSolid, true, true)) {
				x += xoffset;
				break;
			}
		}
		xspd = 0;
	} else x += xspd;
}

//判断是否需要重力
var needGrav = (yspd != 0);
if(!needGrav)
	needGrav = !collision_line(bbox_left + 1, bbox_bottom + 1, bbox_right - 1, bbox_bottom + 1, oSolid, true, true);
//如果需要重力，则让yspd加上grav
if(needGrav) {
	yspd += grav;
}

//跳跃
if(collision_line(bbox_left + 1, bbox_bottom + 2, bbox_right - 1, bbox_bottom + 2, oSolid, true, true)) {
	jumpTimes = 0;
	jumpedOut = false;
	if(alarm[0] > 0)
		alarm[0] = -1;
} else if(!jumpedOut) {
	alarm[0] = 6;
	jumpedOut = true;
}
if(keyboard_check_pressed(global.keyJump)) {
	if(jumpTimes < jumpTimesMax) {
		yspd = jumpSpd;
		jumpTimes++;
	}
}

//限制yspd
if(yspd > yspdMax)
	yspd = yspdMax;
if(abs(yspd) < 0.001)	//避免精度问题
	yspd = 0;

if(yspd > 0) {	//若有向下的速度
	//判断即将移动到的位置是否和oSolid碰撞，如果碰撞则吸附
	if(collision_line(bbox_left + 1, bbox_bottom + yspd, bbox_right - 1, bbox_bottom + yspd, oSolid, true, true)) {
		for(var yoffset = yspd - 1; yoffset > 0; yoffset--) {
			if(!collision_line(bbox_left + 1, bbox_bottom + yoffset, bbox_right - 1, bbox_bottom + yoffset, oSolid, true, true)) {
				y += yoffset;
				break;
			}
		}
		yspd = 0;
	} else y += yspd;
} else if(yspd < 0) {	//若有向上的速度
	//判断即将移动到的位置是否和oSolid碰撞，如果碰撞则吸附
	if(collision_line(bbox_left + 1, bbox_top + yspd, bbox_right - 1, bbox_top + yspd, oSolid, true, true)) {
		for(var yoffset = yspd + 1; yoffset < 0; yoffset++) {
			if(!collision_line(bbox_left + 1, bbox_top + yoffset, bbox_right - 1, bbox_top + yoffset, oSolid, true, true)) {
				y += yoffset;
				break;
			}
		}
		yspd = 0;
	} else y += yspd;
}

//横向切换场景
if(x < 0 || x > room_width) {
	var borderPortalId = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, oHBorderPortal, false, true);
	if(borderPortalId != noone) {
		if(borderPortalId.isInPortal(id) && borderPortalId.isVaild()) {
			borderPortalInfo = new BorderPortalInfo(id, borderPortalId);
			borderPortalInfo.subimg = image_index;
			instance_change(oPlayer_InPortal, true);
			exit;
		}
	}
	xspd = 0;
	x = (x < 0 ? 0 : room_width);
}

//纵向切换场景
var vcenter = (bbox_top + bbox_bottom) / 2;
if((vcenter < 0 && yspd <= 0) || (vcenter > room_height && yspd >= 0)) {
	var borderPortalId = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, oVBorderPortal, false, true);
	if(borderPortalId != noone) {
		if(borderPortalId.isInPortal(id) && borderPortalId.isVaild()) {
			borderPortalInfo = new BorderPortalInfo(id, borderPortalId);
			borderPortalInfo.subimg = image_index;
			instance_change(oPlayer_InPortal, true);
			exit;
		}
	}
	if(vcenter > room_height) {
		kill();
		exit;
	}
}

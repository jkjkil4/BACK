//设置视野位置
if(instance_exists(oPlayer_InPortal)) {
	setViewPos(0, oPlayer_InPortal.x - getViewW(0) / 2, oPlayer_InPortal.y - getViewH(0) / 2);
} else if(instance_exists(oPlayer)) {
	setViewPos(0, getViewBoundX(oPlayer.xprevious), getViewBoundY(oPlayer.yprevious));
}
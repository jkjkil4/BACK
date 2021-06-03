//设置视野位置
if(instance_exists(oPlayer_InPortal)) {
	scrSetViewPos(0, oPlayer_InPortal.x - scrViewW(0) / 2, oPlayer_InPortal.y - scrViewH(0) / 2);
} else if(instance_exists(oPlayer)) {
	scrSetViewPos(0, scrViewBoundX(oPlayer.xprevious), scrViewBoundY(oPlayer.yprevious));
}
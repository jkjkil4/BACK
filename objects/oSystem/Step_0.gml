//设置视野位置
if(instance_exists(oPlayer)) {
	var viewWidth = scrViewW(0), viewHeight = scrViewH(0);
	scrSetViewPos(0, scrBound(0, oPlayer.xprevious - viewWidth / 2, room_width - viewWidth), 
					 scrBound(0, oPlayer.yprevious - viewHeight / 2, room_height - viewHeight));
}
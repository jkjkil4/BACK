if(DEBUG) {
	if(global.dbgTextVisible) {
		//初始化调试信息
		var debugMsg = "";

		//调试信息 - 基本
		debugMsg += "FPS:" + string(fps) + " SI:" + string(global.save.index) 
			+ " DeathC:" + string(global.save.deathCount) + " ExitC:" + string(global.save.exitCount) + "\n";

		//调试信息 - 玩家
		if(instance_exists(oPlayer)) {
			debugMsg += "Player x:" + string(oPlayer.x) + " y:" + string(oPlayer.y)
			          + " xspd:" + string(oPlayer.xspd) + " yspd:" + string(oPlayer.yspd) + "\n"
					  + "  jumpTimes:" + string(oPlayer.jumpTimes) + "/" + string(oPlayer.jumpTimesMax) + "\n";
		}

		//绘制调试信息
		draw_set_color(c_black);
		draw_text(0, 2, debugMsg);
		draw_set_color(global.colors.lightGray);
		draw_text(0, 0, debugMsg);
	}
}
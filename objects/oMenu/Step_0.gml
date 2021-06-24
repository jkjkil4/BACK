

if(global.sys.focusedWidget() == id) {
	var size = ds_list_size(tabList);

	if(size != 0) {
		var tmpCurIndex = curIndex;
		
		//根据按键改变tmpCurIndex
		if(isUp()) tmpCurIndex--;
		if(isDown()) tmpCurIndex++;
	
		//限制tmpCurIndex
		if(tmpCurIndex < 0)
			tmpCurIndex = size - 1;
		else if(tmpCurIndex >= size)
			tmpCurIndex = 0;
	
		//更新curIndex
		if(tmpCurIndex != curIndex) {
			curIndex = tmpCurIndex;
			updateYOffsetTo();
		}
	
		//按下确认键时触发
		if(isEnter()) {
			var tab = tabList[| curIndex];
			if(tab.args == undefined) {
				tab.fn()
			} else tab.fn(tab.args);
		}
	}
	
	//按下取消键时关闭
	if(closeable && isCancel())
		close();
}


//让yOffset接近yOffsetTo
if(yOffsetTo != yOffset) {
	var delta = yOffsetTo - yOffset;
	var spd = delta / 3;
	if(abs(spd) < 2)
		spd = sign(spd) * 2;
	yOffset = (abs(spd) >= abs(delta) ? yOffsetTo : yOffset + spd);
}
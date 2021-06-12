

if(global.sys.focusedWidget() == id) {
	var size = ds_list_size(tabList);

	if(size != 0) {
		var tmpCurIndex = curIndex;
		
		//根据按键改变tmpCurIndex
		if(keyboard_check_pressed(vk_up))
			tmpCurIndex--;
		if(keyboard_check_pressed(vk_down))
			tmpCurIndex++;
	
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
		if(keyboard_check_pressed(global.keyEnter)) {
			var tab = tabList[| curIndex];
			tab.fn(tab.args);
		}
	}
	
	//按下取消键时关闭
	if(closeable && keyboard_check_pressed(global.keyCancel))
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
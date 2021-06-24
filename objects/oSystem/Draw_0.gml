if(DEBUG) {
	if(global.gridVisible) {
		//绘制网格
		var viewX = getViewX(0), viewY = getViewY(0), viewW = getViewW(0), viewH = getViewH(0);
		var gridStartX = floor(max(0, viewX) / 128) * 128;
		var gridStartY = floor(max(0, viewY) / 128) * 128;
		var gridEndX = min(room_width, viewX + viewW);
		var gridEndY = min(room_height, viewY + viewH);
		var left = max(0, viewX);
		var top = max(0, viewY);
		draw_set_alpha(0.4);
		draw_set_color(c_blue);
		for(var i = gridStartX; i < gridEndX; i += 128)
			draw_line_width(i, top, i, gridEndY, 2);
		for(var j = gridStartY; j < gridEndY; j += 128)
			draw_line_width(left, j, gridEndX, j, 2);
		draw_set_color(c_white);
		draw_set_alpha(1);
	}
}
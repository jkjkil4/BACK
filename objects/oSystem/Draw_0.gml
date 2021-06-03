if(DEBUG) {
	//绘制网格
	var viewX = scrViewX(0), viewY = scrViewY(0);
	var gridStartX = floor(viewX / 128) * 128;
	var gridStartY = floor(viewY / 128) * 128;
	var gridEndX = viewX + scrViewW(0);
	var gridEndY = viewY + scrViewH(0);
	draw_set_alpha(0.4);
	draw_set_color(c_blue);
	for(var i = gridStartX; i < gridEndX; i += 128)
		draw_line_width(i, viewY, i, gridEndY, 2);
	for(var j = gridStartY; j < gridEndY; j += 128)
		draw_line_width(viewX, j, gridEndX, j, 2);
	draw_set_color(c_white);
	draw_set_alpha(1);	
}
beforeDraw();

var len = array_length(elements);
var color = make_color_rgb(250, 250, 255);
for(var i = 0; i < len; i++) {
	var element = elements[i];
	draw_sprite_ext(
		sTitleDot, -1,
		tx(lx(element[ElemIdx.X])), ty(ly(element[ElemIdx.Y] - t)), 
		element[ElemIdx.Scale], element[ElemIdx.Scale],
		t * element[ElemIdx.RotSpd] + element[ElemIdx.RotDef], color, 1
		);
}

afterDraw(false);
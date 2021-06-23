var viewW = scrViewW(0), viewH = scrViewH(0);

process = 1;
shaderX = x - scrViewX(0);
shaderY = y - sprite_get_height(sPlayer) / 2 - scrViewY(0);
maxDistance = max(
	point_distance(0, 0, shaderX, shaderY),
	point_distance(0, viewH, shaderX, shaderY),
	point_distance(viewW, 0, shaderX, shaderY),
	point_distance(viewW, viewH, shaderX, shaderY)
	)

surf = surface_create(viewW, viewH);
surface_copy(surf, 0, 0, application_surface);
x = savePointX;
y = savePointY;

room_restart();
draw_sprite(sPlayer, 0, x, y);

/*var vcenter = y - sprite_get_height(sPlayer) / 2;
var dir;
var aph = 1 - sqr(1 - process);
var dis = 30 * aph;
draw_set_alpha(aph);
for(var i = 0; i < 3; i++) {
	dir = 360 * i / 3 + process * 500;
	draw_circle(x + dcos(dir) * dis, vcenter + dsin(dir) * dis, 4, false);
}*/

if(surface_exists(surf)) {
	shader_set(shaderTrCircleOut);
	setShaderCircleOutUniform(maxDistance, 1 - process, 0.15, shaderX, shaderY);
	draw_surface(surf, getViewX(0), getViewY(0));
	shader_reset();
}
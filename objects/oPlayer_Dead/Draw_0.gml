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
	//draw_set_alpha(process);
	
	shader_set(shaderTrCircleOut);
	var uniMaxDistance = shader_get_uniform(shaderTrCircleOut, "u_fMaxDistance");
	shader_set_uniform_f(uniMaxDistance, maxDistance);
	var uniProcess = shader_get_uniform(shaderTrCircleOut, "u_fProcess");
	shader_set_uniform_f(uniProcess, 1 - process);
	var uniStep = shader_get_uniform(shaderTrCircleOut, "u_fStep");
	shader_set_uniform_f(uniStep, 0.1);
	var uniPosition = shader_get_uniform(shaderTrCircleOut, "u_vPosition");
	shader_set_uniform_f_array(uniPosition, [shaderX, shaderY]);
	
	draw_surface(surf, scrViewX(0), scrViewY(0));
	
	shader_reset();
	//draw_set_alpha(1);
}
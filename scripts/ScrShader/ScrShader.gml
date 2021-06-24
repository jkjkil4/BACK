// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrShaderCircleOutSetUniform(_maxDistance, _process, _step, _x, _y) {
	var uniMaxDistance = shader_get_uniform(shaderTrCircleOut, "u_fMaxDistance");
	shader_set_uniform_f(uniMaxDistance, _maxDistance);
	var uniProcess = shader_get_uniform(shaderTrCircleOut, "u_fProcess");
	shader_set_uniform_f(uniProcess, _process);
	var uniStep = shader_get_uniform(shaderTrCircleOut, "u_fStep");
	shader_set_uniform_f(uniStep, _step);
	var uniPosition = shader_get_uniform(shaderTrCircleOut, "u_vPosition");
	shader_set_uniform_f_array(uniPosition, [_x, _y]);
}
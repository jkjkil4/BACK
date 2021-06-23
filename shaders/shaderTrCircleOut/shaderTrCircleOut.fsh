//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_fMaxDistance;
uniform float u_fProcess;
uniform float u_fStep;
uniform vec2 u_vPosition;

void main()
{
	float from = u_fProcess * (1.0 + u_fStep) - u_fStep;
	
	vec2 origPos = vec2(v_vTexcoord.x * 800.0, v_vTexcoord.y * 608.0);
	float dis = distance(origPos, u_vPosition);
	float aph = clamp((dis / u_fMaxDistance - from) / u_fStep, 0.0, 1.0);
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.a *= aph;
}

varying vec2 vv_tex;

const vec3 outline = vec3(8.0, 8.0, 8.0) / 255.0;
const vec2 texels = 1.0 / vec2(256.0, 256.0);

void main() {
	vec4 pixel = texture2D(gm_BaseTexture, vv_tex);
	vec2 offsets[8];
	
	offsets[0] = vec2(1.0, 0.0);
	offsets[1] = vec2(1.0, -1.0);
	offsets[2] = vec2(0.0, -1.0);
	offsets[3] = vec2(-1.0, -1.0);
	offsets[4] = vec2(-1.0, 0.0);
	offsets[5] = vec2(-1.0, 1.0);
	offsets[6] = vec2(0.0, 1.0);
	offsets[7] = vec2(1.0, 1.0);
	
	float alpha = 0.0;
	
	for (int i = 0; i < 8; i++) {
		alpha = alpha + texture2D(gm_BaseTexture, vv_tex + (offsets[i] * texels)).a;
	}
	
	if (pixel.a == 0.0 && alpha > 0.0) {
		pixel = vec4(outline, 1.0);
	}
	
	gl_FragColor = pixel;
}
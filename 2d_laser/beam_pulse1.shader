shader_type canvas_item;
//render_mode blend_premul_alpha;

void fragment() {
	//float glow = 16.6 * sin(TIME*10.0);
	float glow = 0.01 / SCREEN_PIXEL_SIZE.x * sin(TIME * 10.0);
	glow = clamp(glow, 2.0, 10.0);
	float curve = 1.0 - abs(UV.y - 0.5) * 15.0;
    float i = clamp(curve, 0.0, 1.0);
    i += clamp((glow + curve) / glow, 0.1, 0.9);
    COLOR = i * vec4(3.0, 0.3, 0.1, 1.0);
}
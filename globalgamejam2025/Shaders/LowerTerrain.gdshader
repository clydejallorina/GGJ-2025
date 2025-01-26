shader_type canvas_item;

uniform bool weighted = true;

void fragment() {
	COLOR.rgb = mix(
		vec3((COLOR.r + COLOR.b + COLOR.g) / 3.0),
		vec3(0.1 * COLOR.r + 0.1 * COLOR.b + 0.1 * COLOR.g),
		float(weighted)
	);
}

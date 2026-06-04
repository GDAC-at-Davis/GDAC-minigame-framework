shader_type canvas_item;
//render_mode unshaded; // optional

// Noise texture
uniform sampler2D noise_texture: repeat_enable, filter_nearest;
// Fog speed
uniform vec2 speed = vec2(0.02, 0.01);

// Called for every pixel the material is visible on
void fragment() {
	// Make the fog slowly move
	vec2 uv = UV + speed * TIME;
	// Sample the noise texture
	COLOR.rgb = texture(noise_texture, uv).rgb;
}
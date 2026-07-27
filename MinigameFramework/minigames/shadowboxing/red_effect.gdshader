shader_type canvas_item;

// Allows sampling the screen texture in Godot 4
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform vec4 red_tint : source_color = vec4(1.0, 0.0, 0.0, 0.5); // Red color with 0.5 alpha
uniform float intensity : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    // Get the original screen color
    vec4 screen_color = texture(screen_texture, SCREEN_UV);

    // Mix the screen color with the red tint
    vec3 tinted_rgb = mix(screen_color.rgb, red_tint.rgb, intensity);

    // Apply the final color
    COLOR = vec4(tinted_rgb, screen_color.a);
}
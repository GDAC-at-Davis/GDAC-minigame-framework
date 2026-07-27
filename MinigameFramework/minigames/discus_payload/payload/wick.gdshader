shader_type canvas_item;

uniform float burn_cover;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (COLOR.a > 0.0)
	{
		if (UV.y + 0.1 < burn_cover)
		{
			COLOR = vec4(0.0, 0.0, 0.0, 0.0);
		}
		else if (UV.y < burn_cover)
		{
			COLOR = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

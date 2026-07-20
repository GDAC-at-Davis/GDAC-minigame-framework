extends ColorRect

func animate_red_flash():
	var tween = create_tween()
	var material = self.material as ShaderMaterial
	# Animate intensity from 0.0 to 1.0 over 0.1 seconds
	tween.tween_property(material, "shader_parameter/intensity", 1.0, 0.1)
	
	# Optional: Fade it back to 0.0 immediately after
	tween.tween_property(material, "shader_parameter/intensity", 0.0, 0.2)

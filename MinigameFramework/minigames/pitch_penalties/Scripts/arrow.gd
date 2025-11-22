extends Sprite2D

var turning:bool = true
var turning_left:bool = true

var growing:bool = false
var growing_bigger:bool = false

func _process(_delta) -> void:
	var difficulty:float = GameManager.minigame_manager.difficulty_scale
	# rotate arrow from -140 to -40 degrees (left to right)
	if turning:
		self.position = Vector2(640,630)
		self.centered = false
		self.offset = Vector2(150,-254)
		
		if turning_left:
			self.rotation_degrees = self.rotation_degrees - 2*difficulty
		else: 
			self.rotation_degrees = self.rotation_degrees + 2*difficulty
			
		if self.rotation_degrees < -140:
			turning_left = false
		
		if self.rotation_degrees > -40:
			turning_left = true
			
	# scale arrow from 0.1 to 0.2
	if growing:
		self.position = Vector2(640,570)
		self.centered = true
		self.offset = Vector2(0,0)
		
		if growing_bigger:
			self.global_scale = self.global_scale + Vector2(0.002,0.002)*difficulty
		else: 
			self.global_scale = self.global_scale - Vector2(0.002,0.002)*difficulty
			
		if self.scale.length() > 0.28284:
			growing_bigger = false
		
		if self.scale.length() < 0.14142:
			growing_bigger = true
			

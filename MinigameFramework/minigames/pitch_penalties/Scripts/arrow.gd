extends Sprite2D

var turning:bool = true
var turning_left:bool = true

var growing:bool = false
var growing_bigger:bool = true

func _process(_delta) -> void:
	var difficulty:float = GameManager.minigame_manager.difficulty_scale
	# rotate arrow from -140 to -40 degrees (left to right)
	if turning:
		self.position = Vector2(640,630)
		self.centered = false
		self.offset = Vector2(150,-254)
		
		if turning_left:
			self.rotation_degrees = self.rotation_degrees + 1*difficulty
		else: 
			self.rotation_degrees = self.rotation_degrees + 1*difficulty
			
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
			self.scale = self.scale + Vector2(0.01,0.01)*difficulty
		else: 
			self.scale = self.scale - Vector2(0.01,0.01)*difficulty
			
		if self.scale.x > 0.2:
			growing_bigger = false
		
		if self.rotation_degrees < 0.1:
			growing_bigger = true
			

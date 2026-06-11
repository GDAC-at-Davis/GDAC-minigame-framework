extends StaticBody2D

const SPEED = 5

var moving_left:bool = true

func _process(_delta: float) -> void:
	var difficulty:float = GameManager.minigame_manager.difficulty_scale
	
	if moving_left:
		self.position.x = self.position.x - SPEED*difficulty
	else:
		self.position.x = self.position.x + SPEED*difficulty
	
	if self.position.x < (355 + 100*(1-difficulty)):
		moving_left = false
		
	if self.position.x > (925 - 100*(1-difficulty)):
		moving_left = true
		

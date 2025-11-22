extends TileMapLayer


func _process(_delta: float) -> void:
	var difficulty:float = GameManager.minigame_manager.difficulty_scale
	self.scale.x = (570 + (100*(1-difficulty)*2)) / 570

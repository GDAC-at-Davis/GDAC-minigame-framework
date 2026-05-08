extends Minigame

@export var controller : Node

func _ready():
	controller.payload.defeated.connect(func() : lose())
	

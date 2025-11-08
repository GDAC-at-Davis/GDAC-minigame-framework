extends Minigame

const PICKUP = preload("uid://1x1kcdxmvc3f")

@onready var top_left: Node2D = $TopLeft
@onready var bottom_right: Node2D = $BottomRight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	_spawn_pickup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _spawn_pickup() -> void:
	var pickup:SnakeMinigamePickup = PICKUP.instantiate()
	add_child(pickup)
	pickup.global_position.x = lerp(
			top_left.global_position.x,
			bottom_right.global_position.x,
			randf())
	
	pickup.global_position.y = lerp(
			top_left.global_position.y,
			bottom_right.global_position.y,
			randf())
	
	pickup.picked_up.connect(_spawn_pickup)

extends Minigame

const PICKUP = preload("uid://1x1kcdxmvc3f")

signal pickup_gotten(current_count:int)

@onready var top_left: Node2D = $TopLeft
@onready var bottom_right: Node2D = $BottomRight
@onready var player: CharacterBody2D = $Player

@export var pickup_target:int = 3
var pickups_gotten:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for _i in max(0, roundi(difficulty) - 1):
		player.elongate()
	player.speed = player.BASE_SPEED * difficulty
	if difficulty > 1:
		countdown_time /= difficulty
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
	
	pickup.picked_up.connect(_on_pickup_picked_up)


func _on_pickup_picked_up() -> void:
	pickups_gotten += 1
	pickup_gotten.emit(pickups_gotten)
	
	if pickups_gotten >= pickup_target:
		win()

	_spawn_pickup()

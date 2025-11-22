extends Minigame

const PICKUP = preload("uid://1x1kcdxmvc3f")
const BASE_EGG_COUNT:int = 3

signal pickup_gotten(current_count:int)


@onready var top_left: Node2D = $TopLeft
@onready var bottom_right: Node2D = $BottomRight
@onready var player: CharacterBody2D = $Player
@onready var eggs_left: Label = $EggsLeft

var pickup_target:int = BASE_EGG_COUNT
var pickups_gotten:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	for _i in max(0, roundi((difficulty - 1) * 5)):
		player.elongate()
	
	player.speed = player.BASE_SPEED * difficulty
	
	#Increase pickup target by 1 every 100% difficulty change
	pickup_target = BASE_EGG_COUNT + floori(difficulty - 1)
	
	self.instruction = "Pick up %s eggs!" % pickup_target
	
	_spawn_pickup()
	_update_eggs_left()


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
	_update_eggs_left()


func _update_eggs_left() -> void:
	eggs_left.text = "%d eggs left!" % max(0, pickup_target - pickups_gotten)

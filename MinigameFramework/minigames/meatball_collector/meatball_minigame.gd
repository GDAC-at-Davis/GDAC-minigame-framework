extends Minigame

var meatball_packed_scene: PackedScene = preload("res://minigames/meatball_collector/meatball.tscn")
var collect_count: int = 0
var base_meatball_amount: int = 6
var meatball_amount: int = base_meatball_amount

@onready var meatball_container: Node2D = $MeatballContainer
@onready var cloud_container: Node2D = $Clouds       # clouds parent
@onready var basket: Area2D = $Basket

var spawn_timer: Timer

# when the game starts
func start() -> void:
	# reset variables
	collect_count = 0
	# adjust for difficulty
	meatball_amount = base_meatball_amount * roundi(difficulty)
	print(meatball_amount)
	# start a time so that it waits for a little before the meatballs start falling
	spawn_timer = Timer.new()
	spawn_timer.one_shot = true
	add_child(spawn_timer)
	spawn_timer.wait_time = 1.0
	spawn_timer.timeout.connect(spawn_next_meatball)
	spawn_timer.start()

# this spawns more meatballs
func spawn_next_meatball() -> void:
	if collect_count >= meatball_amount:
		return

	spawn_meatball()
	spawn_timer.wait_time = randf_range(0.5, 1.0)
	spawn_timer.start()


func spawn_meatball() -> void:
	var meatball: Area2D = meatball_packed_scene.instantiate()
	meatball_container.add_child(meatball)

	# spawn anywhere along the top of the screen, at spawn_line's Y
	var screen_width: float = get_viewport().get_visible_rect().size.x
	#ensuring the meatballs stay within the edges
	var random_x: float = randf_range(30, screen_width- 30)
	
	# spawning it at the top of the screen 
	var spawn_y := get_viewport().get_visible_rect().position.y + 10
	
	meatball.global_position = Vector2(random_x, spawn_y)

# make sure we run the same functions every frame
func run() -> void:
	move_meatballs()
	check_catches()
	check_falls()
	
	# we can update the win function since its hard to collect all of them
	if collect_count >= meatball_amount:
		win()

# physics process for the meatballs
# it creates the falling effect for the meatballs on screen
func move_meatballs() -> void:
	var dy: float = 200.0 * difficulty * get_physics_process_delta_time()
	for meatball in meatball_container.get_children():
		meatball.position.y += dy

# check if the meatball is caught by the basket
# used a simpler distance to function rather than checking if it hit the top of the basket
func check_catches() -> void:
	for meatball in meatball_container.get_children():
		if basket.global_position.distance_to(meatball.global_position) < 50.0:
			collect_meatball(meatball)

# collect meatball in our basket and increase count 
func collect_meatball(meatball: Node2D) -> void:
	collect_count += 1
	meatball.queue_free()

# check if the meatball touched the ground 
# if any meatball touch the ground, fail
func check_falls() -> void:
	var screen_bottom: float = get_viewport().get_visible_rect().size.y + 60.0
	for meatball in meatball_container.get_children():
		if meatball.global_position.y > screen_bottom:
			lose()
			return
			
func win():
	super()

func lose():
	super()

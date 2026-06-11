extends Minigame

# Pattern variables
var current_pattern: String = ""
var input_progress: String = ""
var base_pattern_length: int = 4
var pattern_length: int = base_pattern_length

# Timing variables
var start_time: float = 0.0
var completion_time: float = 0.0
var best_time: float = 999.0 
const SAVE_PATH = "user://react_wasd_best_time.save"

# UI references
@onready var key_container: HBoxContainer = $KeyContainer
@onready var feedback_label: Label = $FeedbackLabel
@onready var time_label: Label = $TimeLabel

# Valid keys for pattern generation
const VALID_KEYS = ["W", "A", "S", "D"]
var key_textures = {}


func _ready():
	# Load the key 
	key_textures["W"] = load("res://minigames/react_wasd/1.png")
	key_textures["A"] = load("res://minigames/react_wasd/2.png")
	key_textures["S"] = load("res://minigames/react_wasd/3.png")
	key_textures["D"] = load("res://minigames/react_wasd/4.png")
	load_best_time()
	super()


func start():
	# Reset variables
	current_pattern = ""
	input_progress = ""
	pattern_length = base_pattern_length
	start_time = Time.get_ticks_msec() / 1000.0

	# Adjust for difficulty
	pattern_length = base_pattern_length + roundi(difficulty * 1.5)
	countdown_time = max(3.0, 7.0 / difficulty)

	generate_pattern()
	update_display()
	feedback_label.text = ""
	time_label.text = ""


func generate_pattern():
	current_pattern = ""
	for i in range(pattern_length):
		current_pattern += VALID_KEYS[randi() % VALID_KEYS.size()]


func run():
	# Check for WASD input
	if Input.is_action_just_pressed("up"):
		process_input("W")
	elif Input.is_action_just_pressed("left"):
		process_input("A")
	elif Input.is_action_just_pressed("down"):
		process_input("S")
	elif Input.is_action_just_pressed("right"):
		process_input("D")


func process_input(key: String):
	if has_ended:
		return

	# Check if input matches the current position in pattern
	if key == current_pattern[input_progress.length()]:
		# Correct input
		input_progress += key
		update_display()
		if input_progress.length() == current_pattern.length():
			# Calculate completion time
			completion_time = (Time.get_ticks_msec() / 1000.0) - start_time

			# Display time and check for new record
			var time_text = "Time: %.2fs" % completion_time
			if completion_time < best_time:
				best_time = completion_time
				save_best_time()
				feedback_label.text = "NEW RECORD! " + time_text
				feedback_label.modulate = Color(1, 0.84, 0) 
			else:
				feedback_label.text = "Perfect! " + time_text
				feedback_label.modulate = Color(0.3, 1, 0.3)

			# Show best time
			time_label.text = "Best: %.2fs" % best_time
			time_label.modulate = Color(1, 1, 1)

			win()
	else:
		# Wrong input
		feedback_label.text = "Wrong! Try again!"
		feedback_label.modulate = Color(1, 0.3, 0.3)
		input_progress = ""
		update_display()
		await get_tree().create_timer(0.5).timeout
		if not has_ended:
			feedback_label.text = ""


func update_display():
	# Clear existing display
	for child in key_container.get_children():
		child.queue_free()

	# Display one row with typed keys bright and untyped keys dark
	for i in range(current_pattern.length()):
		var key = current_pattern[i]
		var texture_rect = TextureRect.new()
		texture_rect.texture = key_textures[key]
		texture_rect.custom_minimum_size = Vector2(100, 100)
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

		if i < input_progress.length():
			texture_rect.modulate = Color(0.5, 1, 0.5)  
		else:
			texture_rect.modulate = Color(0.15, 0.15, 0.15)  

		key_container.add_child(texture_rect)


func win():
	super()


func lose():
	super()
	feedback_label.text = "Time's up!"
	feedback_label.modulate = Color(1, 0.5, 0.3)


func load_best_time():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			best_time = file.get_float()
			file.close()


func save_best_time():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_float(best_time)
		file.close()

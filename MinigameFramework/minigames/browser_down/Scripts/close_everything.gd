extends Minigame

var window_packed_scene : PackedScene = preload("res://minigames/browser_down/window.tscn")
var base_number_of_windows : int = 5
var ham_percentage : float = 0.8 # what percent of the windows should be "good windows"
var number_of_windows : int = base_number_of_windows
var playing : bool = false
var num_hams = 0
var num_illegals = 0

var ham_images = [
	preload("res://minigames/browser_down/Assets/ham1.png"),
	preload("res://minigames/browser_down/Assets/ham2.png"),
	preload("res://minigames/browser_down/Assets/ham3.png")
]

var illegal_images = [
	preload("res://minigames/browser_down/Assets/illegal1.png"),
	preload("res://minigames/browser_down/Assets/illegal2.png"),
	preload("res://minigames/browser_down/Assets/illegal3.png")
]

var windows = []
var illegals = []
var hams = []

func start() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	number_of_windows *= roundi(difficulty)
	spawn_windows()

func send_to_top(window):
	window.z_index = len(windows)
	for w in windows:
		if w != window:
			w.z_index -= 1
	
func _multiply_string(s : String, multiple : int):
	var final = ""
	for i in range(multiple):
		final += s
	return final

func _create_window(illegal : bool = false) -> void:
	var w = window_packed_scene.instantiate()
	add_child(w)
	if not illegal:
		w.set_image(ham_images[randi_range(0, len(ham_images) - 1)])
		w.illegal = false
		hams.append(w)
	else:
		w.set_image(illegal_images[randi_range(0, len(ham_images) - 1)])
		w.illegal = true
		illegals.append(w)
	windows.append(w)
	w.z_index = len(windows) + 1
	var randx = randf_range(get_viewport().get_visible_rect().size.x * 0.2, get_viewport().get_visible_rect().size.x * 0.8)
	var randy = randf_range(get_viewport().get_visible_rect().size.y * 0.1, get_viewport().get_visible_rect().size.y * 0.9)
	w.global_position = Vector2(randx, randy)
	var new_scale = randf_range(0.30, 0.5)
	w.scale = Vector2(new_scale, new_scale)

func spawn_windows() -> void:
	num_hams = roundi(ham_percentage * number_of_windows)
	num_illegals = number_of_windows - num_hams
	var queue = _multiply_string("0", num_hams) + _multiply_string("1", num_illegals)
	for i in queue:
		if i == "0":
			_create_window(false)
		else:
			_create_window(true)
	playing = true
			
func _process(delta: float) -> void:
	if playing:
		if len(illegals) == 0:
			win()
		if len(hams) != num_hams:
			lose()

func remove_window(window):
	windows.erase(window)
	hams.erase(window)
	illegals.erase(window)

func win():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	super()

func lose():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	super()

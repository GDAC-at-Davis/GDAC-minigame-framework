extends Control

# game related vars
var illegal : bool = false
@onready var image_texturerect : TextureRect = $WindowVBox/Panel/Image

@onready var drag = $Winow/WindowVBox/Drag

# dragging vars
var dragging = false
var offset = Vector2.ZERO

func _on_drag_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not dragging:
		if event.is_pressed():
			get_parent().send_to_top(self)
			dragging = true
			offset = get_global_mouse_position() - global_position
	elif event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and dragging:
		if event.is_released():
			dragging = false

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - offset

func set_image(i):
	image_texturerect.texture = i

# closing and fullscreening

func _on_close_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			get_parent().remove_window(self)
			queue_free()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			get_parent().send_to_top(self)

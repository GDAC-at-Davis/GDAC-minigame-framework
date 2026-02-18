extends Control

@export var dialogues : Array[String]
@export var images : Array[Texture2D]

@onready var image : TextureRect = $Margin/ImageTextVBox/Image
@onready var text : RichTextLabel = $Margin/ImageTextVBox/Text

var current_dialogue : int = 0

var text_speed : float = 1.0
var text_threshold : float = 0.1
var text_counter : float = 0.0

var playing_text : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_text()
	GameManager.world_manager.play_music("Cutscene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playing_text:
		text_counter += delta * text_speed
		play_text()

func start_text():
	text.text = dialogues[current_dialogue]
	image.texture = images[current_dialogue]
	playing_text = true
	text.visible_characters = 0

func play_text():
	if text_counter >= text_threshold:
		if text.visible_characters < len(text.text):
			text.visible_characters += 1
		else:
			playing_text = false
			text_counter = 0


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		if playing_text:
			text.visible_characters = len(text.text)
			playing_text = false
		else:
			current_dialogue += 1
			if current_dialogue < len(dialogues):
				start_text()
			else:
				GameManager.world_manager.pause_music()
				GameManager.world_manager.load_level("Home")

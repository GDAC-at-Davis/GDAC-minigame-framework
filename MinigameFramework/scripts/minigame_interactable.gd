class_name MinigameInteractable
extends Interactable

@export var minigame_id: StringName
@export var interaction_text: Array[String] = ["Example text."]
@export var minigame_group: MinigameGroupData

var can_interact: bool:
	get():
		return _interaction_cooldown_timer.time_left <= 0.0

var _interaction_cooldown_timer: Timer

func _ready():
	_interaction_cooldown_timer = Timer.new()
	_interaction_cooldown_timer.one_shot = true
	_interaction_cooldown_timer.autostart = false
	add_child(_interaction_cooldown_timer)

func interact(player: Character):
	if not can_interact:
		return
	var overworld: Overworld = GameManager.current_scene as Overworld
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(interaction_text)

func _on_dialogue_completed():
	var overworld: Overworld = GameManager.current_scene as Overworld
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)
	GameManager.minigame_manager.all_minigames_completed.connect(_on_all_minigames_completed)
	overworld.play_minigames(minigame_group)

func _on_all_minigames_completed(won: bool):
	var overworld: Overworld = GameManager.current_scene as Overworld
	await overworld.overworld_loading_completed
	_interaction_cooldown_timer.start(3.0)
	if won:
		overworld.add_completed_minigame(minigame_id)
		overworld.dialogue_box.play_text(["You received the %s Star!" % minigame_id.capitalize()])
		GameManager.minigame_manager.all_minigames_completed.disconnect(_on_all_minigames_completed)

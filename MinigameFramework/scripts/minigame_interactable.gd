class_name MinigameInteractable
extends Interactable

@export var minigame_id: StringName
@export var interaction_text: Array[String] = ["Example text."]
@export var minigame_group: MinigameGroupData

func interact(player: Character):
	var overworld: Overworld = GameManager.current_scene as Overworld
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(interaction_text)

func _on_dialogue_completed():
	var overworld: Overworld = GameManager.current_scene as Overworld
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)
	GameManager.minigame_manager.all_minigames_completed.connect(_on_all_minigames_completed)
	overworld.play_minigames(minigame_group)

func _on_all_minigames_completed(won: bool):
	if won:
		var overworld: Overworld = GameManager.current_scene as Overworld
		overworld.add_completed_minigame(minigame_id)
		GameManager.minigame_manager.all_minigames_completed.disconnect(_on_all_minigames_completed)

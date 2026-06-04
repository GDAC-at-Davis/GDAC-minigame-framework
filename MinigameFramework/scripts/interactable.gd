class_name Interactable
extends Area2D

@export var interaction_text: Array[String] = ["Example text."]
@export var minigame_group: MinigameGroupData

func interact(player: Character):
	var overworld: Overworld = GameManager.current_scene as Overworld
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(interaction_text)

func _on_dialogue_completed():
	var overworld: Overworld = GameManager.current_scene as Overworld
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)
	overworld.play_minigames(minigame_group)

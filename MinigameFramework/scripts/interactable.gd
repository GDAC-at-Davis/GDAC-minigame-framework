class_name Interactable
extends Area2D

@export var interaction_text: Array[String] = ["Example text."]
@export var minigame_group: MinigameGroupData

func interact(player: Character):
	(GameManager.current_scene as Overworld).dialogue_box.play_text(interaction_text, minigame_group)

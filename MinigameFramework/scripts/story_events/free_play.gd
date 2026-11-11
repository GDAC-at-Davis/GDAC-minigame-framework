extends StoryEvent

var acquired_star_scene = preload("res://scenes/acquired_star.tscn")
var star: AnimatedSprite2D

func on_enter():
	# Let the player control Dakki
	overworld.controller.possessed = overworld.dakki
	overworld.minigame_completed.connect(on_minigame_completed)

func on_update():
	GameManager.play_music(load("res://assets/audio/room_of_stars.mp3"), 1.0, false)

func on_exit():
	overworld.minigame_completed.disconnect(on_minigame_completed)

func on_minigame_completed():
	star = acquired_star_scene.instantiate()
	overworld.dakki.add_child(star)
	star.global_position = overworld.dakki.global_position
	star.play("appear")
	star.animation_finished.connect(on_star_animation_finished)
	if overworld.get_completed_minigame_count() >= overworld.TOTAL_MINIGAMES:
		complete()

func on_star_animation_finished():
	star.queue_free()

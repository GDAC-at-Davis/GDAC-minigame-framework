class_name SoundPlayer
extends AudioStreamPlayer

@export var tracks: Array[AudioStream] = []

func play_track(track_num: int) -> void:
	if track_num >= tracks.size():
		return
	
	stream = tracks[track_num]
	play()

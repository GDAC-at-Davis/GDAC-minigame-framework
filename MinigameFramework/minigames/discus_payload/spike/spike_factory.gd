@tool
extends Node2D

## the scene of an individual spike
@export var spike_scene : PackedScene

## this is the radius of the spike sphere
@export var radius : float : 
	set(value):
		radius = value 
		if Engine.is_editor_hint():
			queue_redraw() 

## this is the number of intervals or the minimum distance that spikes can be 
## from each other
@export var num_of_intervals : int :
	set(value):
		num_of_intervals = value
		if Engine.is_editor_hint():
			queue_redraw() 

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, radius, Color.RED, false)
		for interval in num_of_intervals:
			var pos : Vector2 = get_pos_on_circle(interval)
			draw_circle(pos, 10, Color.CRIMSON, true)

func _ready() -> void:
	if not Engine.is_editor_hint():
		generate_spikes(3, 3)
		
# stores info on where the intervals. marks intervals with gaps
var has_gap : Dictionary

func get_pos_on_circle(interval : int) -> Vector2:
	return radius * Vector2(cos(interval * 2 * PI / num_of_intervals), sin(interval * 2 * PI / num_of_intervals))

func generate_spikes(num_gaps : int, gap_size : int) -> void:
	# decide the intervals 
	for gap in num_gaps:
		var start_interval : int = randi() % num_of_intervals
		for interval in range(start_interval, start_interval + gap_size):
			has_gap[interval] = true

	# go through and generate spikes 
	for interval in num_of_intervals:
		if not has_gap.has(interval):
			var instance := spike_scene.instantiate()
			add_child(instance)
			instance.owner = self
			instance.position = get_pos_on_circle(interval)

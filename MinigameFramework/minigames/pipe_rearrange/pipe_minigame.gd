extends Minigame

var pipes : Array[Pipe] = []
var pipes_out_of_order = 5
var all_connect: int = 0

@onready var celeb_particles_tl: GPUParticles2D = $CelebrationParticleTL
@onready var celeb_particles_tr: GPUParticles2D = $CelebrationParticleTR

func start():
	# im getting all the pipes into a list and returning to their default
	for pipe in get_children():
		if pipe is Pipe:
			pipes.append(pipe)
			pipe.rotation_degrees = pipe.correct_rotation
	
	countdown_time = 7 / difficulty
	
	# im getting random pipes and scrambling them
	for i in range(pipes_out_of_order):
		var pipe = pipes[randi_range(0, len(pipes) - 1)]
		pipe.rotation_degrees += 90

func _process(_delta):
	pipe_connect_stats()


func win():
	celeb_particles_tl.emitting = true
	celeb_particles_tr.emitting = true
	super()


func pipe_connect_stats():
	# list of amounts of pipes that are connected
	all_connect = 0
	for pipe in pipes:
		if pipe._is_correct_rotation:
			all_connect += 1
	if all_connect == len(pipes):
		win()

extends Minigame

var pipes : Array[Pipe] = []
var pipes_out_of_order = 5
var all_connect: int = 0

func start():
	# im getting all the pipes into a list and returning to their default
	for pipe in get_children():
		if pipe is Pipe:
			pipes.append(pipe)
			pipe.rotation_degrees = pipe.correct_rotation
	
	countdown_time /= difficulty
	
	# im getting random pipes and scrambling them
	for i in range(pipes_out_of_order):
		var pipe = pipes[randi_range(0, len(pipes) - 1)]
		pipe.rotation_degrees += 90

func win():
	super()

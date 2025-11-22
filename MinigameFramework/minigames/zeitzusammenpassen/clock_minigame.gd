"""
A minigame wherein a digital clock is shown wiþ some 12-hr time,
along wiþ 3 analog clocks, and the player must select the clock
that displays the same time as the digital clock.

The þeme is 'strictness' and 'complexity', as time is seen as strict,
and analog clocks, imcomprehensibly to me, complex

The analog clock displays roman numerals instead of hindu-arabic numerals
to add a layer of difficulty upon the fact that player has to read an analog clock.
This choice of numerals, along wiþ the font choice for the results, 
reinforces the aforementioned þemes

Zeitzusammenpassen means Time-match in German. I am learning German and thought
the German meþod of coining new words by fusing many others, as opposed to hyphenating
them as in English, to add to the sense of 'strictness' and 'complexity' that I wanted
my minigame to embody.
"""
extends Minigame

const CLOCK_COUNT:int = 3
const CLOCKS:String = "clocks"
const WIN_MSG:String = "CORRECT"
const LOSE_MSG:String = "INCORRECT"
const WIN_COLOR:Color = Color.GOLDENROD
const LOSE_COLOR:Color = Color.DARK_RED

@onready var digital_clock:Node = $DigitalClock
@onready var result_display:Node = $ResultDisplay

var clock_packed_scene: PackedScene = preload("res://minigames/zeitzusammenpassen/clock.tscn")
var correct_clock:int # index of the correct clock
var correct_time:Vector2 # the correct time, stored as Vector2(hours, minutes)


func start():
	# reset vars
	correct_clock = 0
	correct_time = Vector2(0.0, 0.0)
	digital_clock.set_time(Vector2(0.0, 0.0))
	result_display.set_text("")
	
	# determine which is the correct clock
	correct_clock = randi() % 3
	
	# Adjust for difficulty
	countdown_time /= difficulty
	
	# set correct time beforehand so that an 'incorrect' clock has not the same time
	correct_time = Vector2(randi_range(1, 12), randi_range(0, 60))
	
	for i in range(CLOCK_COUNT):
		var clock: Area2D = clock_packed_scene.instantiate()
		add_child(clock)
		clock.add_to_group(CLOCKS) # add to group so that they can be from the other children distinguished
		
		
		
		# if this is the correct clock, set correct_time and the digital_clock to its time
		if i == correct_clock:
			clock.set_correct(true)
			clock.set_time(correct_time)
			digital_clock.set_time(correct_time)
		else:
			clock.set_correct(false)
			# generate a time, stored in a Vector2(hours, minutes)
			var time:Vector2
			
			# generate times until a time distinct from the correct time is generated
			while true:
				time = Vector2(randi_range(1, 12), randi_range(0, 60))
				
				if not time.is_equal_approx(correct_time):
					break
			
			clock.set_time(time)
		
		# evenly space (horizontally) the three clocks, in the bottom half of the viewport
		clock.global_position = Vector2(
				get_viewport().get_visible_rect().size.x * 0.25 * (i + 1), 
				get_viewport().get_visible_rect().size.y * 2/3
			)


func win():
	super()
	# display the win message in the appropriate color
	result_display.set_color(WIN_COLOR)
	result_display.set_text(WIN_MSG)


func lose():
	super()
	# display the lose message in the appropriate color
	result_display.set_color(LOSE_COLOR)
	result_display.set_text(LOSE_MSG)

# function called by the clocks when selected
# clears all clocks, and whether the correct was selected or not,
# determines if the minigame was won or not, respectively
func clock_selected(correct: bool):
	# remove all clocks from screen
	for clock in get_tree().get_nodes_in_group(CLOCKS):
		clock.queue_free()
	
	# call win or lose based on if the correct clock was selected
	if correct:
		win()
	else:
		lose()

extends StoryEvent

var _dialogue: Array[String] = [
	"Dakki has powered up!",
	"Dakki: I'm making that game.",
	"Dakki: I'm making it with Gee.",
	"Dakki: I don't care about the profit.",
	"Dakki: I'm making it.",
	"Monster: You think that'll work?",
	"Monster: Just a few words and I'm gone?",
	"Dakki: Of course not. I have to do something.",
	"Dakki pulls out a chair and sits down. She begins to work on a game titled The Adventures of Gee and Dakki.",
	"She smiles as she works. The process is frustrating but rewarding.",
	"As she tests her game, the screen becomes brighter than any setting would allow.",
	"Gee springs from the screen and into real life!",
	"Gee: D-Dakki…",
	"Dakki stands wordlessly for a moment.",
	"Dakki: ...Gee!",
	"The two embrace in a tight hug, not paying any mind to the thickening fog.",
	"Gee: I've missed you so much!",
	"Dakki: Me too! I didn't know what to do and the room! The room went all dark and—",
	"Gee: I know, I know. It's okay now.",
	"Gee: And Dakki…",
	"Dakki: ?",
	"Gee: I'm ready to finish our game now.",
	"Dakki: Really?",
	"Gee: I've had a lot of time to think! It really got those creative juices flowing!",
	"Dakki: Let's do it!",
	"The two work on the game for hours in the smog. The game is near completion.",
	"Monster: There's no way you'll finish this.",
	"Gee: Quiet. We're busy.",
	"Monster: Hmph.",
	"Hours pass and the smog starts to fade.",
	"A star comes from the screen and the room turns white.",
	"The smog is gone. The air is clear and the girls breathe a sigh of relief.",
	"Dakki: We did it. We're done…",
	"Gee: Hahhh. What a relief!",
	"Gee: I really feel like I got it all out!",
	"Dakki: And that nasty smog…",
	"Gee: Sealed away again?",
	"Dakki: I guess?",
	"Dakki: The stars are all gone too…",
	"Dakki: Gee…",
	"Gee: Hm?",
	"Dakki: It's good to have you back.",
	"Gee: Hehe.",
	"Gee: I missed you.",
	"Gee: So, what's our next game?",
	]

func on_enter():
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(_dialogue)

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)

func _on_dialogue_completed():
	complete()

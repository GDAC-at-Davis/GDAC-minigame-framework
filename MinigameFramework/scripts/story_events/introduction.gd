extends StoryEvent

var text: Array[String] = [
	"Long ago, there were two tribes who could not be more different.",
	"One tribe was the Artisans—lovers of art, humanity, and culture.",
	"They valued literature and craft and the mastery of all creation.",
	"The other tribe, Technologists, were experts in science, logic, and mechanics.",
	"Their society was advanced and efficient—unlike anything the world had ever seen before.",
	"Both societies were asocial, never acknowledging the world outside their circle.",
	"But a plague struck both lands.",
	"Though the Technologists were able to save some of their own with their advanced medicine, those that were cured would quickly succumb to misery without the joy of the arts.",
	# Vamp around here
	"The Artisans, though happy, had to watch their numbers deplete as their outdated medicine could not keep up with the fast-growing plague.",
	"The leaders of the tribes decided that this would not last. A solution had to be found or all of their people would meet an early end.",
	"The two tribes, despite their dislike for interaction outside of their own kind, joined hands.",
	"The Artisans spread the goodness of song, dance, and craft while the Technologists whipped up life-saving medicine in the blink of an eye.",
	"From here on, the two tribes would be good allies of one another, always depending on each other in times of need.",
	"All was well until the tribes were met with their greatest foe.",
	"A giant beast made of steam and smog terrorized their villages.",
	"Things should only be made for profit.",
	"What good is art and technology without the benefits of wealth?",
	"The monster spread words of discouragement and the people became downtrodden.",
	"The tribe leaders decided that this would not last. A solution had to be found or the foundations of their societies would crumble.",
	"So, they rounded up their greatest warriors.",
	"Make things! they said. Make things just because you want to.",
	"And so they did.",
	"They thought and thought and thought,",
	"Then, they came up with the ultimate culmination of all of their skills.",
	"VIDEO GAMES.",
	"With the creation of INSERT NUMBER OF MINIGAMES HERE cornerstone games, the beast was sealed away.",
]

func on_enter():
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(text)

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)

func _on_dialogue_completed():
	complete()

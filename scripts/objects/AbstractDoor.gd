tool

extends Interactable

class_name AbstractDoor

const sound_locked = "res://assets/sounds/door_locked.mp3"
const sound_open = "res://assets/sounds/door_open.mp3"

export (bool) var locked = false
export (String) var key = null

onready var audio: AudioStreamPlayer2D = $Audio

func interact(player: Player):
	if locked:
		for item in player.items:
			if item.has_method("get_key") and item.get_key() == self.key:
				locked = false
				break
	
	if locked:
		interact_locked(player)
	else:
		interact_unlocked(player)

func interact_locked(_player: Player):
	play_sound(sound_locked)

func interact_unlocked(_player: Player):
	if not audio.is_playing():
		play_sound(sound_open)

func play_sound(sound):
	var stream = load(sound)
	stream.set_loop(false)
	audio.stream = stream
	audio.play()
	

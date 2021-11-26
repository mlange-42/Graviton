tool

extends Interactable

class_name AbstractDoor

export (bool) var locked = false

func interact(player: Player):
	if locked:
		interact_locked(player)
	else:
		interact_unlocked(player)

func interact_locked(_player: Player):
	pass

func interact_unlocked(_player: Player):
	pass

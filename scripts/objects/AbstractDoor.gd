tool

extends Interactable

class_name AbstractDoor

export (bool) var locked = false
export (String) var key = null

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
	pass

func interact_unlocked(_player: Player):
	pass

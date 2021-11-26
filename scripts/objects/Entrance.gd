extends Interactable

class_name Entrance

func interact(player):
	if abs(player.global_rotation - self.global_rotation) >= 0.01:
		return
		
	var level = Levels.current_level - 1
	if not Levels.load_level(level):
		if get_tree().change_scene("scenes/MainMenu.tscn") == OK:
			Levels.current_level = 0

extends Interactable

class_name Entrance

func interact(_player):
	var level = Levels.current_level - 1
	if not Levels.load_level(level):
		if get_tree().change_scene("scenes/MainMenu.tscn") == OK:
			Levels.current_level = 0

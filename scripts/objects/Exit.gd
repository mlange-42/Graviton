extends Interactable

class_name Exit

func interact(_player):
	var level = Levels.current_level + 1
	if Levels.levels.size() > level:
		var scene = Levels.levels[level] + ".tscn"
		if get_tree().change_scene("scenes/levels/"+scene) == OK:
			Levels.current_level = level
	else:
		if get_tree().change_scene("scenes/MainMenu.tscn") == OK:
			Levels.current_level = 0

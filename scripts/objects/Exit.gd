extends Interactable

class_name Exit

func interact(player):
	if abs(Math.angle_deg_between(self.global_rotation_degrees, player.global_rotation_degrees)) >= 0.01:
		return
		
	var level = Levels.current_level + 1
	if not Levels.load_level(level):
		if get_tree().change_scene("scenes/MainMenu.tscn") == OK:
			Levels.current_level = 0

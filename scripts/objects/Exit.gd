extends AbstractDoor

class_name Exit

func _ready():
	# warning-ignore:return_value_discarded
	$Timer.connect("timeout", self, "load_level")

func interact_unlocked(player):
	.interact_unlocked(player)
	
	if abs(Math.angle_deg_between(self.global_rotation_degrees, player.global_rotation_degrees)) >= 0.01:
		return
	
	get_tree().paused = true
	$Timer.start()

func load_level():
	var level = Levels.current_level + 1
	
	if not Levels.load_level(level):
		if get_tree().change_scene("scenes/MainMenu.tscn") == OK:
			Levels.current_level = 0

extends Control

onready var levels_container: GridContainer = $Levels

func _ready():
	for i in range(Levels.levels.size()):
		var b = LevelButton.new()
		
		b.level = i
		b.rect_min_size = Vector2(60, 60)
		b.text = str(i + 1)
		
		if i > Levels.player_level:
			b.disabled = true
		
		b.connect("pressed", self, "_on_level_button_pressed", [b])
		
		levels_container.add_child(b)
	
	get_tree().paused = false

func _on_level_button_pressed(button: LevelButton):
	# warning-ignore:return_value_discarded
	Levels.load_level(button.level)

func _on_exit_button_pressed():
	get_tree().quit()

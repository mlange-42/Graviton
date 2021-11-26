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

func _on_level_button_pressed(button: LevelButton):
	var level = button.level
	var scene = Levels.levels[level] + ".tscn"
	
	if get_tree().change_scene("scenes/levels/"+scene) == OK:
		Levels.current_level = level

func _on_exit_button_pressed():
	get_tree().quit()

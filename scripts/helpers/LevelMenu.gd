extends Control

class_name LevelMenu

func _ready():
	self.visible = false

func _on_ResumeButton_pressed():
	self.visible = false


func _on_RestartButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene(get_tree().current_scene.filename)


func _on_MainMenuButton_pressed():
	if get_tree().change_scene("scenes/MainMenu.tscn") == OK:
		Levels.current_level = 0

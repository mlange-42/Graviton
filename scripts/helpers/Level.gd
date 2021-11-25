extends Node2D

onready var menu: LevelMenu = $LevelMenuLayer/LevelMenu

func _input(event):
	if event.is_action_pressed("menu"):
		menu.visible = not menu.visible

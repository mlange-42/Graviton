extends Node2D

onready var player: Player = $Player
onready var menu: LevelMenu = $LevelMenuLayer/LevelMenu

func _ready():
	if Levels.go_back:
		var exit = $Level/Objects/Exit
		player.teleport(exit)

func _input(event):
	if event.is_action_pressed("menu"):
		menu.visible = not menu.visible

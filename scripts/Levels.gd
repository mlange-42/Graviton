extends Node

var player_level: int = 0
var current_level: int = 0
var go_back: bool = false

var levels: Array = [
	"Level_001",
	"Level_002",
	"Level_003",
	"Level_004",
	"Level_005",
	"Level_006"
]

func load_level(index) -> bool:
	go_back = index == current_level - 1
	if index >= 0 and index < levels.size():
		var scene = levels[index] + ".tscn"
		if get_tree().change_scene("scenes/levels/"+scene) == OK:
			current_level = index
			if player_level < current_level:
				player_level = current_level
				
			return true
	
	return false

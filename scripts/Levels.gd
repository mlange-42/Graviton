extends Node

var current_level: int = 0
var go_back: bool = false

var levels: Array = [
	"Level_001",
	"Level_002",
	"Level_003"
]

func load_level(index) -> bool:
	go_back = index == current_level - 1
	if index >= 0 and index < levels.size():
		var scene = levels[index] + ".tscn"
		if get_tree().change_scene("scenes/levels/"+scene) == OK:
			current_level = index
			return true
	
	return false

extends Node

const store_file: String = "user://graviton.sav"

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

func _ready():
	load_user()

func load_level(index) -> bool:
	go_back = index == current_level - 1
	if index >= 0 and index < levels.size():
		var scene = levels[index] + ".tscn"
		if get_tree().change_scene("scenes/levels/"+scene) == OK:
			current_level = index
			if player_level < current_level:
				player_level = current_level
				save_user()
				
			return true
	
	return false

func save_user():
	var file = File.new()
	file.open(store_file, File.WRITE)
	file.store_var(player_level)
	file.close()

func load_user():
	var file = File.new()
	if file.file_exists(store_file):
		file.open(store_file, File.READ)
		player_level = file.get_var()
		file.close()
	else:
		player_level = 0

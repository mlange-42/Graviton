extends Camera2D

export (NodePath) var target_path

var target: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(target_path)

func _process(delta):
	position = lerp(position, target.position, 2.0 * delta)

extends Camera2D

export (NodePath) var target_path

var target: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(target_path)

func _process(delta):
	position = lerp(position, target.position, 2.0 * delta)
	
	var angle = target.rotation_degrees - rotation_degrees
	angle = fmod(angle + 180, 360) - 180
	
	self.rotation_degrees += min(angle, 180 * delta) if angle > 0 else max(angle, -180 * delta)
	

extends Camera2D

export (NodePath) var target_path

onready var blur: ColorRect = $Blur

var target: Node2D
var blur_amount = 0

func _ready():
	target = get_node(target_path)
	# warning-ignore:return_value_discarded
	target.connect("player_teleported", self, "_on_player_teleported")

func _process(delta):
	if (position - target.position).length() > 10:
		position = lerp(position, target.position, 2.5 * delta)
	
	var max_angle = 270 * delta
	var angle = target.rotation_degrees - rotation_degrees
	
	angle = mod(angle + 180, 360) - 180
	angle = min(angle, max_angle) if angle > 0 else max(angle, -max_angle)
	
	if angle == 0:
		blur.material.set_shader_param("blur_amount", 0)
	else:
		var target_blur = 2 * abs(angle) / max_angle
		var value = 0.2 if target_blur > blur_amount else 0.5 
		
		blur_amount = lerp(blur_amount, target_blur, value)
		
		blur.material.set_shader_param("blur_amount", blur_amount)
		
		self.rotation_degrees += angle

func _on_player_teleported():
	position = target.position
	rotation = target.rotation

func mod(a, n):
	return a - floor(a/n) * n 

tool

extends Interactable

class_name Door

export (NodePath) var other_door
var other: Door

func _ready():
	other = get_node(other_door)

func interact(player: Player):
	if abs(Math.angle_deg_between(self.global_rotation_degrees, player.global_rotation_degrees)) < 0.01 and other != null:
		player.teleport(other)

func _draw():
	if Engine.editor_hint and other != null:
		draw_line(Vector2.ZERO, other.position - self.position, Color.white)

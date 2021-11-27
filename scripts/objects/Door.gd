tool

extends AbstractDoor

class_name Door

export (NodePath) var other_door
var other: Door

func _ready():
	other = get_node(other_door)

func interact_unlocked(player: Player):
	.interact_unlocked(player)
	
	if other != null:
		player.teleport(other)

func _draw():
	if Engine.editor_hint and other != null:
		draw_line(Vector2.ZERO, other.position - self.position, Color.white)

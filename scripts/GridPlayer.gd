extends Area2D

var tile_size = 64

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

onready var ray = $RayCast2D
onready var tween = $Tween

export var speed = 6

func _ready():
	position = position.snapped(Vector2.ONE * 0.5 * tile_size)

func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action(dir):
			move(dir)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(dir)

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/speed, Tween.TRANS_LINEAR)
	tween.start()

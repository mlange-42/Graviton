extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -800
export (int) var gravity = 2000

export (float, 0, 1.0) var friction = 0.25
export (float, 0, 1.0) var acceleration = 0.35
export (float, 0, 1.0) var air_factor = 0.2

onready var sprite = $Sprite

var velocity = Vector2.ZERO

func get_input():
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
	
	var fac = 1.0 if self.is_on_floor() else air_factor
	
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, fac * acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, fac * friction)

func _process(delta):
	if self.is_on_floor():
		sprite.frame = 0
	else:
		sprite.frame = 1

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed

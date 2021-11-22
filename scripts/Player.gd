extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -800
export (int) var gravity = 2000

export (float, 0, 1.0) var friction = 0.25
export (float, 0, 1.0) var acceleration = 0.35
export (float, 0, 1.0) var air_factor = 0.2

onready var sprite: Sprite = $Sprite
onready var ray_left: RayCast2D = $RayLeft
onready var ray_right: RayCast2D = $RayRight
onready var ray_down: RayCast2D = $RayDown

onready var tween: Tween = $Tween

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
	
	if not Input.is_action_pressed("dont_stick"):
		check_rotation()

func _process(delta):
	if self.is_on_floor():
		sprite.frame = 0
	else:
		sprite.frame = 1

func _physics_process(delta):
	if tween.is_active():
		return
		
	get_input()
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity.rotated(self.rotation), Vector2.UP.rotated(self.rotation))
	velocity = velocity.rotated(-self.rotation)
	
	if abs(velocity.x) < 1:
		velocity.x = 0
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	
	update()

func check_rotation():
	if not self.is_on_floor():
		return
	
	# Concave corners
	
	var ray: RayCast2D = null
	var dir: int = 0
	if velocity.x < 0:
		ray = ray_left
		dir = 1
	elif velocity.x > 0:
		ray = ray_right
		dir = -1
	
	if ray != null:
		ray.force_raycast_update()
		if ray.is_colliding():
			tween.interpolate_property(self, "rotation", self.rotation, self.rotation + PI * 0.5 * dir, 0.1)
			tween.start()
			# self.rotate(PI * 0.5 * dir)
			return
	
	# Convex corners
	
	ray_down.force_raycast_update()
	if ray_down.is_colliding():
		return
	
	var angle = PI * 0.5 * sign(velocity.x)
	var center = self.position + Vector2(0, 25).rotated(self.rotation)
	
	tween.interpolate_property(self, "rotation", self.rotation, self.rotation + angle, 0.1)
	tween.interpolate_property(self, "position", self.position, center + (self.position - center).rotated(angle), 0.1)
	tween.start()
	
	#self.rotate_around_foot(angle)
	
func rotate_around_foot(angle):
	var center = self.position + Vector2(0, 25).rotated(self.rotation)
	self.position = center + (self.position - center).rotated(angle)
	self.rotate(angle)

func _draw():
	draw_line(Vector2.ZERO, Vector2.UP * 50, Color.red)
	draw_line(Vector2.ZERO, velocity * 0.2, Color.green)
	

extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -800
export (int) var gravity = 2000

export (float, 0, 1.0) var friction = 0.25
export (float, 0, 1.0) var acceleration = 0.35
export (float, 0, 1.0) var air_factor = 0.2

var min_speed = 1

export (bool) var debug_draw = false

onready var sprite: Sprite = $Sprite
onready var ray_left: RayCast2D = $RayLeft
onready var ray_right: RayCast2D = $RayRight
onready var ray_down: RayCast2D = $RayDown
onready var ray_down_left: RayCast2D = $RayDownLeft
onready var ray_down_right: RayCast2D = $RayDownRight

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

func _process(_delta):
	if debug_draw:
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
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Lethals":
			self.die()
			return
	
	if abs(velocity.x) < min_speed:
		velocity.x = 0
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	
	if not Input.is_action_pressed("dont_stick"):
		check_rotation()
	
	if debug_draw:
		update()

func check_rotation():
	# Do not apply physics and input during corner moves
	if not self.is_on_floor():
		return
	
	# Concave corners
	
	var ray: RayCast2D = null
	var dir: int = 0
	if velocity.x < -min_speed:
		ray = ray_left
		dir = 1
	elif velocity.x > min_speed:
		ray = ray_right
		dir = -1
	
	if ray != null:
		ray.force_raycast_update()
		if ray.is_colliding():
			if ray.get_collider().name == "Lethals":
				self.die()
			
			# warning-ignore:return_value_discarded
			tween.interpolate_property(self, "rotation", self.rotation, self.rotation + PI * 0.5 * dir, 0.1)
			# warning-ignore:return_value_discarded
			tween.start()
			return
	
	# Convex corners
	
	ray_down.force_raycast_update()
	if ray_down.is_colliding():
		return
	
	ray_down_left.force_raycast_update()
	ray_down_right.force_raycast_update()
	if velocity.x > -min_speed and ray_down_right.is_colliding():
		return
	if velocity.x < min_speed and ray_down_left.is_colliding():
		return
	
	var angle = PI * 0.5 * sign(velocity.x)
	var center = self.position + Vector2(0, 25).rotated(self.rotation)
	
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "rotation", self.rotation, self.rotation + angle, 0.1)
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "position", self.position, center + (self.position - center).rotated(angle), 0.1)
	# warning-ignore:return_value_discarded
	tween.start()

func die():
	get_tree().change_scene(get_tree().current_scene.filename)
	
func rotate_around_foot(angle):
	var center = self.position + Vector2(0, 25).rotated(self.rotation)
	self.position = center + (self.position - center).rotated(angle)
	self.rotate(angle)

func _draw():
	if debug_draw:
		draw_line(Vector2.ZERO, Vector2.UP * 50, Color.red)
		draw_line(Vector2.ZERO, velocity * 0.2, Color.green)
		
		draw_line(ray_left.position, ray_left.position + ray_left.cast_to, Color.blue)
		draw_line(ray_right.position, ray_right.position + ray_right.cast_to, Color.blue)
		
		draw_line(ray_down.position, ray_down.position + ray_down.cast_to, Color.blue)
		draw_line(ray_down_left.position, ray_down_left.position + ray_down_left.cast_to, Color.blue)
		draw_line(ray_down_right.position, ray_down_right.position + ray_down_right.cast_to, Color.blue)
	

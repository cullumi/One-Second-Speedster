extends KinematicBody

export (int) var move_speed = 15
export (int) var look_speed = 3

onready var camera = $Camera
onready var mesh = $MeshInstance
onready var col_shape = $CollisionShape

var is_paused = true

func _ready():
	add_to_group("player")
	add_to_group("pausable")
	mesh.visible = false

func _process(delta):
	if is_paused:
		aiming(delta)
		movement()

func movement():
	var velocity = Vector3()
	var direction = Vector3()
	var forward_direction = rotation_degrees.y
	
	var is_moving = false
	if Input.is_action_pressed("move_left"):
		direction.x += sin(deg2rad(forward_direction - 90))
		direction.z += cos(deg2rad(forward_direction - 90))
		is_moving = true
	if Input.is_action_pressed("move_right"):
		direction.x += sin(deg2rad(forward_direction + 90))
		direction.z += cos(deg2rad(forward_direction + 90))
		is_moving = true
	if Input.is_action_pressed("move_forward"):
		direction.x += sin(deg2rad(forward_direction - 180))
		direction.z += cos(deg2rad(forward_direction - 180))
		is_moving = true
	if Input.is_action_pressed("move_back"):
		direction.x += sin(deg2rad(forward_direction))
		direction.z += cos(deg2rad(forward_direction))
		is_moving = true
	velocity = direction.normalized() * move_speed
	
	if !is_on_floor():
		velocity.y = -move_speed
	else:
		velocity += -get_slide_collision(0).normal * 100
	
	move_and_slide(velocity, Vector3.UP)

func aiming(delta):
	var velocity = Vector3()
	var direction = Vector3()
	
	if Input.is_action_pressed("look_left"):
		direction.y += 1;
	if Input.is_action_pressed("look_right"):
		direction.y -= 1;
	if Input.is_action_pressed("look_up"):
		direction.x += 1
	if Input.is_action_pressed("look_down"):
		direction.x -= 1;
	velocity = direction.normalized() * look_speed
	
	var look_velocity = velocity * delta
	camera.rotate_x(look_velocity.x)
	rotate_y(look_velocity.y)
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -75, 75)

func unpause():
	is_paused = false
	col_shape.disabled = true

func add_collision_exceptions(bodies):
	for body in bodies:
		add_collision_exception_with(body)
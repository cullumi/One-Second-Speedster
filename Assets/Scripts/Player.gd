extends KinematicBody

export (int) var move_speed = 15
export (int) var look_speed = 2
export (int) var push_force = 10

export (int) var forward_fov = 90
export (int) var strafing_fov = 77
export (int) var default_fov = 70
export (int) var fov_speed = 64

signal can_interact

onready var camera = $Camera
onready var mesh = $MeshInstance
onready var col_shape = $CollisionShape
onready var ray_cast = $Camera/RayCast

var is_paused = true
var can_interact = false

var is_moving
var is_moving_forward = false

var MOUSE_SENSITIVITY = 0.05

func _ready():
	add_to_group("player")
	add_to_group("pausable")
	mesh.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if is_paused:
		interacting()
		aiming(delta)
		movement()
		adjust_fov(delta)

func adjust_fov(delta):
	if is_moving and is_moving_forward:
		if camera.fov < forward_fov:
			camera.fov += delta * fov_speed
		elif camera.fov > forward_fov:
			camera.fov = forward_fov
	elif is_moving:
		if camera.fov < strafing_fov:
			if (camera.fov + delta * fov_speed) > strafing_fov:
				camera.fov = strafing_fov
			else:
				camera.fov += delta * fov_speed
		elif camera.fov > strafing_fov:
			if (camera.fov - delta * fov_speed) < strafing_fov:
				camera.fov = strafing_fov
			else:
				camera.fov -= delta * fov_speed
	else:
		if camera.fov > default_fov:
			camera.fov -= delta * fov_speed
		elif camera.fov < default_fov:
			camera.fov = default_fov

func interacting():
	if ray_cast.is_colliding():
		var body = ray_cast.get_collider()
		if ray_cast.get_collider().is_in_group("interactable"):
#			print("Found Interactable Object")
			emit_signal("can_interact", body.get_interaction_label())
			if Input.is_action_just_pressed("interact"):
				body.interact(self)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        camera.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
        self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

        var camera_rot = camera.rotation_degrees
        camera_rot.x = clamp(camera_rot.x, -70, 70)
        camera.rotation_degrees = camera_rot

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

func movement():
	var velocity = Vector3()
	var direction = Vector3()
	var forward_direction = rotation_degrees.y
	
	is_moving = false
	is_moving_forward = false
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
		is_moving_forward = true
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

func unpause():
	is_paused = false
	col_shape.disabled = true

func add_collision_exceptions(bodies):
	for body in bodies:
		add_collision_exception_with(body)
extends KinematicBody

export (NodePath) var left_path_follow
export (NodePath) var right_path_follow

var is_paused = true
var speed = 10
var is_following_left_path = true

func _ready():
	add_to_group("pausable")

func _process(delta):
	if !is_paused:
		
		var velocity = Vector3()
		var direction = Vector3()
		
		if is_following_left_path:
			direction = global_transform.origin.direction_to(get_node(left_path_follow).global_transform.origin)
		else:
			direction = global_transform.origin.direction_to(get_node(right_path_follow).global_transform.origin)
		
		velocity = direction * speed
		move_and_slide(velocity, Vector3.UP)

func unpause():
	is_paused = false
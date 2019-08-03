extends KinematicBody

export (NodePath) var left_path_follow
export (NodePath) var right_path_follow

export (bool) var is_following_left_path = false

var is_paused = true
var speed = 10

func _ready():
	add_to_group("trolly")
	add_to_group("pausable")

func _process(delta):
	if !is_paused:
		
		var velocity = Vector3()
		var direction = Vector3()
		var target_pos = Vector3()
		var self_pos = global_transform.origin
		
		if is_following_left_path:
			target_pos = get_node(left_path_follow).global_transform.origin
		else:
			target_pos = get_node(right_path_follow).global_transform.origin
		
		direction = self_pos.direction_to(target_pos)
		
		var tf = get_global_transform()
		if Vector2(direction.x, direction.z).length_squared() > 0.001:
			tf.basis = Basis(Vector3(0, 1, 0), atan2(-direction.x, -direction.z))
#		tf.origin += direction * delta
		set_global_transform(tf)
		
		if self_pos.distance_to(target_pos) >= self_pos.distance_to((self_pos + (direction * speed * delta))):
			velocity = direction * speed
			move_and_slide(velocity, Vector3.UP)

func unpause():
	is_paused = false

func set_speed(new_speed):
	self.speed = new_speed
	print(self.speed)
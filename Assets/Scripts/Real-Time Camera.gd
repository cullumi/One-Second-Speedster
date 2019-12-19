extends Camera

export (NodePath) var focus_point

var is_paused = true

func _ready():
	add_to_group("pausable")

func _process(delta):
	if !is_paused:
		global_transform = global_transform.looking_at(get_node(focus_point).global_transform.origin, Vector3.UP)

func unpause():
	is_paused = false
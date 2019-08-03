extends KinematicBody

export (NodePath) var left_path
export (NodePath) var right_path
var is_paused = true

func _process(delta):
	if !is_paused:
		pass
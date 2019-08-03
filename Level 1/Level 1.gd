extends Spatial

func _process(delta):
	if Input.is_action_just_pressed("un-pause"):
		get_tree().call_group("pausable", "unpause")
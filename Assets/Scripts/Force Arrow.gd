extends Spatial

onready var stretch_point = $"Stretch Point"

func set_arrow(target):
	var origin = global_transform.origin
	stretch_point.scale.y = origin.distance_to(target)*2
	
	look_at(target, Vector3.UP)
	
	global_transform.origin = target
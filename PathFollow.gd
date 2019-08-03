extends PathFollow

var is_paused = true
var speed = 10

func _process(delta):
	if !is_paused:
		unit_offset += speed * delta
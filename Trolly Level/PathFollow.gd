extends PathFollow

var is_paused = true
var speed = .2

func _ready():
	add_to_group("pausable")

func _process(delta):
	if !is_paused:
		unit_offset += speed * delta

func unpause():
	is_paused = false
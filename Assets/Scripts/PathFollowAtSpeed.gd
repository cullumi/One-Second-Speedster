extends PathFollow

export (String) var speed_source_key = null

var is_paused = true
var speed = 10

func _ready():
	if speed_source_key != null or speed_source_key != "":
		add_to_group(speed_source_key)
	add_to_group("pausable")

func _process(delta):
	if !is_paused:
		offset += speed * delta

func unpause():
	is_paused = false

func set_speed(new_speed):
	self.speed = new_speed
#	print(self.speed)
extends PathFollow

var is_paused = true
var speed = 10

func _ready():
	add_to_group("trolly")
	add_to_group("pausable")

func _process(delta):
	if !is_paused:
		offset += speed * delta

func unpause():
	is_paused = false

func set_speed(new_speed):
	self.speed = new_speed
	print(self.speed)
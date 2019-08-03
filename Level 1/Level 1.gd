extends Spatial

onready var real_time_cam = $"Real-Time Camera"
onready var player = $Player

var trolly_speed = 40

func _ready():
	get_tree().call_group("trolly", "set_speed", trolly_speed)
	get_tree().call_group("people", "add_collision_exception", player)

func _process(delta):
	if Input.is_action_just_pressed("un-pause"):
		get_tree().call_group("pausable", "unpause")
		
		real_time_cam.current = true
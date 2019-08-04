extends Spatial

onready var real_time_cam = $"Real-Time Camera"
onready var player = $Player
onready var trolly = $Trolly

var trolly_speed = 40

func _ready():
	get_tree().call_group("trolly", "set_speed", trolly_speed)
	get_tree().call_group("people", "add_collision_exception", player)

func _process(delta):
	if Input.is_action_just_pressed("un-pause"):
		get_tree().call_group("pausable", "unpause")
		
		real_time_cam.current = true

func _on_Track_Lever_interacted_with():
	trolly.is_following_left_path = !trolly.is_following_left_path

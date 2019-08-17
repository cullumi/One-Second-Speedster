extends Spatial

signal level_unpaused

onready var real_time_cam = $"Real-Time Camera"
onready var player = $Player
onready var trolly = $Trolly
onready var unpause_delay_timer = $UnPauseDelay
onready var unpause_delay_cam = $"UnPauseDelay Camera"

var trolly_speed = 40
var time_limit = 5

func _ready():
	get_tree().call_group("trolly", "set_speed", trolly_speed)
	get_tree().call_group("people", "add_collision_exception", player)

func _process(delta):
	if Input.is_action_just_pressed("un-pause"):
		unpause_level()

func _on_Track_Lever_interacted_with():
	trolly.is_following_left_path = !trolly.is_following_left_path

func get_player():
	return player

func unpause_level():
	emit_signal("level_unpaused")
	unpause_delay_cam.current = true
	unpause_delay_timer.start()

func _on_UnPauseDelay_timeout():
	unpause_delay_timer.stop()
	get_tree().call_group("pausable", "unpause")
	real_time_cam.current = true

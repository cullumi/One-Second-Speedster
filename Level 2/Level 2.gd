extends Spatial

signal level_unpaused
signal received_casualty

onready var real_time_cam = $"Real-Time Camera"
onready var player = $Player
onready var bullet = $Bullet
onready var unpause_delay_timer = $UnPauseDelay
onready var unpause_delay_cam = $"UnPauseDelay Camera"

var bullet_speed = 50
var time_limit = 4

func _ready():
	get_tree().call_group("bullet", "set_speed", bullet_speed)
	get_tree().call_group("people", "add_collision_exception", player)
	get_tree().call_group("people", "connect", "was_harmed", self, "_on_Person_harmed")

func _process(delta):
	if Input.is_action_just_pressed("un-pause"):
		unpause_level()

func _on_Person_harmed():
	emit_signal("received_casualty")

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

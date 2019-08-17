extends Node

export (Array, PackedScene) var levels

var current_level
var current_level_index
var player

onready var ui = $UI
onready var level_timer = $"Level Timer"
onready var tracer_path = $"Tracer Path"

func _ready():
	ui.level_timer = level_timer
	enter_main_menu()

func _process(delta):
	if Input.is_action_just_pressed("restart_level"):
		load_level(current_level_index)
	if Input.is_action_just_pressed("escape"):
		if !ui.in_main_menu:
			enter_main_menu()
		else:
			get_tree().quit()

func _on_Player_can_interact(label_text):
	ui.show_interaction_label(label_text)

func _on_Level_unpaused():
	ui.hide_level_HUD()
	tracer_path.stop_recording()
	tracer_path.trace()

func _on_Level_Timer_timeout():
	current_level.unpause_level()

func load_level(index):
	if current_level != null:
		level_timer.stop()
		current_level.queue_free()
		current_level = null
	if levels.size() >= (index + 1):
		current_level_index = index
		current_level = levels[index].instance()
		add_child(current_level)
		player = current_level.get_player()
		player.connect("can_interact", self, "_on_Player_can_interact")
		current_level.connect("level_unpaused", self, "_on_Level_unpaused")
		ui.on_enter_level()
		level_timer.wait_time = current_level.time_limit
		level_timer.start()
		tracer_path.player = player
		tracer_path.start_recording()
	else:
		enter_main_menu()

func enter_main_menu():
	if current_level != null:
		level_timer.stop()
		current_level.queue_free()
		current_level = null
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ui.on_enter_main_menu()

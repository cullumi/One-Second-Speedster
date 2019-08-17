extends Control

onready var interaction_panel = $"Interaction Panel"
onready var level_HUD = $"Level HUD"
onready var main_menu = $"Main Menu"
onready var level_timer_label = $"Level HUD/Level Timer Panel/Label"

var interaction_label_was_shown_this_frame = false
var in_main_menu = false
var level_timer

func _process(delta):
	if !in_main_menu:
		if interaction_label_was_shown_this_frame:
			interaction_label_was_shown_this_frame = false
		else:
			hide_interaction_label()
		level_timer_label.text = "%.2fms" % lerp(0, 1, level_timer.time_left/level_timer.wait_time)

func on_enter_main_menu():
	in_main_menu = true
	show_main_menu()
	hide_interaction_label()
	hide_level_HUD()

func on_enter_level():
	in_main_menu = false
	show_level_HUD()
	hide_main_menu()

func show_main_menu():
	main_menu.visible = true

func show_interaction_label(label_text):
	interaction_panel.get_node("Interaction Label").text = label_text
	interaction_panel.visible = true
	interaction_label_was_shown_this_frame = true

func show_level_HUD():
	level_HUD.visible = true

func hide_main_menu():
	main_menu.visible = false

func hide_interaction_label():
	interaction_panel.visible = false

func hide_level_HUD():
	level_HUD.visible = false
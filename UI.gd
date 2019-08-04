extends Control

onready var interaction_label = $"Interaction Label"

var interaction_label_was_shown_this_frame = false

func _process(delta):
	if interaction_label_was_shown_this_frame:
		interaction_label_was_shown_this_frame = false
	else:
		hide_interaction_label()

func show_interaction_label(label_text):
	interaction_label.text = label_text
	interaction_label.visible = true
	interaction_label_was_shown_this_frame = true

func hide_interaction_label():
	interaction_label.visible = false
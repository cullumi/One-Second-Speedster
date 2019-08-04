extends Node

onready var ui = $UI

func _on_Player_can_interact(label_text):
	ui.show_interaction_label(label_text)
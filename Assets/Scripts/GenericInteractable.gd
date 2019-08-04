extends StaticBody

export (String) var interaction_label = "Interact"

signal interacted_with

func _ready():
	add_to_group("interactable")

func interact(interactor):
	emit_signal("interacted_with")

func get_interaction_label():
	return interaction_label
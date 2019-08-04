extends StaticBody

export (String) var interaction_label = "Interact"

signal interacted_with

onready var lever_handle = $"Lever Handle"
onready var flipped_lever_handle = $"Flipped Lever Handle"

var flipped = false

func _ready():
	add_to_group("interactable")

func interact(interactor):
	emit_signal("interacted_with")
	flipped = !flipped
	if flipped:
		lever_handle.visible = false
		flipped_lever_handle.visible = true
	if !flipped:
		lever_handle.visible = true
		flipped_lever_handle.visible = false

func get_interaction_label():
	return interaction_label
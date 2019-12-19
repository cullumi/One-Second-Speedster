extends StaticBody

export (String) var interaction_label = "Interact"

export (NodePath) var switch_unflipped_path = "Lever Handle"
export (NodePath) var switch_flipped_path = "Flipped Lever Handle"

onready var switch_unflipped = get_node(switch_unflipped_path)
onready var switch_flipped = get_node(switch_flipped_path)

signal interacted_with

var flipped = false

func _ready():
	add_to_group("interactable")

func interact(interactor):
	emit_signal("interacted_with")
	flipped = !flipped
	if flipped:
		switch_unflipped.visible = false
		switch_flipped.visible = true
	if !flipped:
		switch_unflipped.visible = true
		switch_flipped.visible = false

func get_interaction_label():
	return interaction_label
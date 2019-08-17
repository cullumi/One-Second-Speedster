extends RigidBody

export (SpatialMaterial) var harmed_material
export (SpatialMaterial) var unharmed_material

export (Vector3) var saved_force = Vector3()
export (String) var interaction_label = "Interact"
export (int) var max_interaction_count = 1

onready var mesh = $"Innocent Rando"
onready var alt_mesh = $"Innocent Rando Small"
onready var force_arrow = $"Force Arrow"
#onready var col_shape = $CollisionShape

var interaction_count = 0

func _ready():
	add_to_group("pausable")
	add_to_group("people")
	add_to_group("interactable")
	contacts_reported = 5
	contact_monitor = true
	mesh.material_override = unharmed_material
	alt_mesh.material_override = unharmed_material

func _on_Innocent_Rando_body_entered(body):
	if body.is_in_group("dangerous"):
		mesh.material_override = harmed_material
		alt_mesh.material_override = harmed_material

func add_collision_exception(body):
	add_collision_exception_with(body)

func unpause():
	force_arrow.visible = false
#	print("Unpaused")
	apply_central_impulse(saved_force)

func interact(interactor):
	if interaction_count < max_interaction_count:
		var interactor_pos = interactor.global_transform.origin
		var self_pos = global_transform.origin
		saved_force += -self_pos.direction_to(interactor_pos) * interactor.push_force
		interaction_count += 1
		force_arrow.set_arrow(self_pos + saved_force)

func get_interaction_label():
	return interaction_label
extends RigidBody

export (String) var interaction_label = "Interact"
export (int) var max_interaction_count = 1

onready var force_arrow = $"Force Arrow"

var saved_velocity
var bullet_speed
var interaction_count = 0

func _ready():
	force_arrow.visible = false
	add_to_group("bullet")
	add_to_group("pausable")
	add_to_group("interactable")

func set_speed(bullet_speed):
	gravity_scale = 0
	self.bullet_speed = bullet_speed
	saved_velocity = -transform.basis.y*bullet_speed

func unpause():
	force_arrow.visible = false
	gravity_scale = 1
	linear_velocity.x = saved_velocity.x
	linear_velocity.y = saved_velocity.y
	linear_velocity.z = saved_velocity.z

func interact(interactor):
	if interaction_count < max_interaction_count:
		var interactor_pos = interactor.global_transform.origin
		var self_pos = global_transform.origin
		saved_velocity += -self_pos.direction_to(interactor_pos) * interactor.push_force
		interaction_count += 1
		force_arrow.set_arrow(self_pos + saved_velocity)
		force_arrow.visible = true

func get_interaction_label():
	return interaction_label
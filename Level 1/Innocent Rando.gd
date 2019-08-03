extends RigidBody

export (SpatialMaterial) var harmed_material
export (SpatialMaterial) var unharmed_material

onready var mesh = $"Innocent Rando"
onready var col_shape = $CollisionShape

func _ready():
	add_to_group("people")
	contacts_reported = 5
	contact_monitor = true
	mesh.material_override = unharmed_material

func _on_Innocent_Rando_body_entered(body):
	if body.is_in_group("dangerous"):
		mesh.material_override = harmed_material

func add_collision_exception(body):
	add_collision_exception_with(body)

extends Path

export (PackedScene) var tracer_particles

onready var tracer = $"Tracer Path Follow"

var player
var is_recording = false
var is_tracing = false

func _process(delta):
	if is_recording and is_instance_valid(player):
		curve.add_point(player.global_transform.origin)
	
	if is_tracing:
		tracer.unit_offset += delta*2
		var par = tracer_particles.instance()
		par.translation = tracer.translation
		par.emitting = true
		add_child(par)
		if tracer.unit_offset >= 1:
			is_tracing = false
			tracer.visible = false
			tracer.unit_offset = 0
			curve.clear_points()

func start_recording():
	is_recording = true

func stop_recording():
	is_recording = false

func trace():
	is_tracing = true
	tracer.visible = true
extends GridContainer

export (PackedScene) var casualty_marker

func add_casualty_marker():
	add_child(casualty_marker.instance())
	columns = ceil(sqrt(get_child_count()))

func reset():
	for child in get_children():
		child.queue_free()
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_picked_up():
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		if(!object.held):
			object.set_process(false)
func _on_put_down():
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		if(!object.held):
			object.set_process(true)
	

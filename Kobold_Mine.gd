extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#when an object is picked up, all other objects turned off. 
func _on_picked_up():
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		if(!object.held):
			object.set_process(false)
	multiple_grabs_handler() #ensures that two assets cannot be picked up at the same time
#when an object is put down, all other objects turn back on
func _on_put_down():
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		if(!object.held):
			object.set_process(true)
#detects the first creature held and "sets down" all of the rest.
func multiple_grabs_handler():
	var held_counter = 0
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		#call the comparison first so that you don't accidentally put down anything you try to pick up
		#if counter is greater than one, pauses other picked up objects
		if(object.held and held_counter>0):
			object.set_process(false)
		#check if any objects are held, if they are increase the counter
		if(object.held):
			held_counter+=1

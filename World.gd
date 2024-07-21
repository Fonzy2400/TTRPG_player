extends Node2D

#main handler for the actual game setup
#TODO: Make it so that the object displayed at the top is the one that gets picked up when creatures overlap
var dark = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#at start turns off visibility of all tiles in tile map... maybe
	var tilesShown = $shows
	var stored = tilesShown.duplicate()
	stored.visible = false
	stored.name = "stored"
	stored.position = Vector2(-1000000,0)
	add_child(stored)
	if dark:
		var coords = tilesShown.get_used_cells(0)
		var coords2 = tilesShown.get_used_cells(1)
		for coord in coords:
			tilesShown.set_cell(0,coord,0,Vector2i(3,3),0)
		for coord in coords2:
			tilesShown.set_cell(1,coord,0,Vector2i(3,3),0)
		#var storagePoint = coord
		#var atlasCoords = stored.get_cell_atlas_coords(0,storagePoint)
		#tilesShown.set_cell(0,storagePoint,0,atlasCoords,0)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	"""
	var tiles = $shows
	var used = tiles.get_used_cells(0)
	var tile = used[0]
	var point = tiles.map_to_local(tile)
	var globalPoint = to_global(point)
	"""
	#print(globalPoint)
#when an object is picked up, all other objects turned off. 
func _on_picked_up():
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		if(!object.held):
			object.selected = false
			#object.set_process(false)
	multiple_grabs_handler() #ensures that two assets cannot be picked up at the same time
#when an object is put down, all other objects turn back on
func _on_put_down():
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		if(!object.held):
			object.set_process(true)
func _on_start_rotate():
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		if(!object.rotating):
			object.set_process(false)
func _on_end_rotate():
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
			object.set_process(true)
#detects the first creature held and "sets down" all of the rest.
func multiple_grabs_handler():
	var held_counter = 0
	var objects = get_tree().get_nodes_in_group("Movables")
	for object in objects:
		#call the comparison first so that you don't accidentally put down anything you try to pick up
		#if counter is greater than one, pauses other picked up objects
		if(object.held and held_counter>0):
			object.held = false
			object.selected = false
		#check if any objects are held, if they are increase the counter
		if(object.held):
			held_counter+=1
func fuck_up_that_tile(Rid): #rename incoming, but it's late and I'm mad
	var tiles = $shows
	var coords = tiles.get_coords_for_body_rid(Rid)
	tiles.set_cell(0,coords,0,Vector2i(3,3),0)
	tiles.set_cell(1,coords,0,Vector2i(3,3),0)
	pass
func restore_that_tile(Rid):
	var tiles = $shows
	var stored = $stored
	var coords = tiles.get_coords_for_body_rid(Rid)
	var atlasCoords = stored.get_cell_atlas_coords(0,coords)
	tiles.set_cell(0,coords,0,atlasCoords,0)


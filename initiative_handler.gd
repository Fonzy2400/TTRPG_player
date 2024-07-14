extends Control
var loadTile

# Called when the node enters the scene tree for the first time.
func _ready():
	loadTile = load("res://turn_order_tile.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("new_combatant")):
		var tile = loadTile.instantiate()
		$player_order.add_child(tile)
	if(Input.is_action_just_pressed("remove_combatant")):
		for child in $player_order.get_children():
			$player_order.remove_child(child)
	
	
		
		
func _text_submitted(text):
	var keepMoving = true
	while(keepMoving):
		var children = $player_order.get_children()
		var count = 0
		var testInitiative = 0
		var moved = false
		for child in children:
			if count > 0:
				testInitiative = children[count-1].initiative
				if testInitiative < child.initiative:
					children[count] = children[count-1]
					children[count-1] = child
					moved = true
			for childs in $player_order.get_children():
				$player_order.remove_child(childs)
			for childss in children:
				$player_order.add_child(childss)
			count+=1
		if(!moved): keepMoving = false

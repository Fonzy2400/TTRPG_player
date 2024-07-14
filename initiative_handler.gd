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

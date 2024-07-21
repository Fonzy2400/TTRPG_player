extends RayCast2D
var lastRID
var correctRID
signal tileBeBack

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("tileBeBack",$"../../..".restore_that_tile)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_colliding():
		var colliderRID = get_collider_rid()
		if colliderRID != lastRID:
			correctRID = colliderRID
			lastRID = colliderRID
			tileBeBack.emit(correctRID)
	pass

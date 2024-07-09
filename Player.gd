extends MoveableObject2D
var count
var radius


# Called when the node enters the scene tree for the first time.
func _ready():
	count = 20
	radius = 24
	for i in range(count):
		var line = RayCast2D.new()
		line.collide_with_areas = true
		line.set_collision_mask(1)
		line.add_to_group("lines")
		add_child(line)
		var point = radius*Vector2(cos(i*2*PI/20),sin(i*2*PI/20))
		#need to move them slightly away from each other so they don't just all detect at zero.
		line.position = point/radius*1
		line.target_position = point


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)


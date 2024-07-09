extends MoveableObject2D
var count
var radius
var isColliding = false


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	var points = PackedVector2Array([])
	count = 50
	radius = 100
	for i in range(count):
		var line = RayCast2D.new()
		line.collide_with_areas = true
		line.set_collision_mask(1)
		line.add_to_group("lines")
		add_child(line)
		var point = radius*Vector2(cos(i*2*PI/count),sin(i*2*PI/count))
		#need to move them slightly away from each other so they don't just all detect at zero.
		line.target_position = point
		points.append(point)
	$Shape.set_polygon(points)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	var check = 0
	for line in get_tree().get_nodes_in_group("lines"):
		if line.is_colliding():
			isColliding = true
			collision()
		else: 
			check+=1
	if check == count:
		new_circle()


func collision():
	var points = PackedVector2Array([])
	for line in get_tree().get_nodes_in_group("lines"):
		if line.is_colliding():
			points.append(line.get_collision_point()-position)
		else:
			points.append(line.target_position)
	$Shape.set_polygon(points)
		
func new_circle():
	var points = PackedVector2Array([])
	for line in get_tree().get_nodes_in_group("lines"):
		points.append(line.target_position)
	$Shape.set_polygon(points)

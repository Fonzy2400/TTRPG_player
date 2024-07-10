extends MoveableObject2D
var count
var radius
var isColliding = false
signal tileBeGone
signal tileBeBack
var collidingCheck = []


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == "World":
		connect("tileBeGone",get_parent().fuck_up_that_tile)
		connect("tileBeBack",get_parent().restore_that_tile)
	super._ready()
	var points = PackedVector2Array([])
	count = 50
	radius = 100
	for i in range(count):
		var line = RayCast2D.new()
		line.collide_with_areas = true
		line.set_collision_mask(2)
		line.add_to_group("lines")
		#add_child(line)
		collidingCheck.append(line.is_colliding())
		var point = radius*Vector2(cos(i*2*PI/count),sin(i*2*PI/count))
		#need to move them slightly away from each other so they don't just all detect at zero.
		line.target_position = point
		points.append(point)
	#$visibleArea/CollisionPolygon2D.set_polygon(points)
	$Shape.set_polygon(points)
	set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	


func collision():
	var points = PackedVector2Array([])
	for line in get_tree().get_nodes_in_group("lines"):
		if line.is_colliding():
			points.append(line.get_collision_point()-position)
		else:
			points.append(line.target_position)
	$visibleArea/CollisionPolygon2D.set_polygon(points)
	$Shape.set_polygon(points)
		
func new_circle():
	var points = PackedVector2Array([])
	for line in get_tree().get_nodes_in_group("lines"):
		points.append(line.target_position)
	$visibleArea/CollisionPolygon2D.set_polygon(points)
	$Shape.set_polygon(points)

func _physics_process(delta):
	var colliders = $visibleArea.get_overlapping_bodies()
	if colliders != []:
		print(colliders)
	var check = 0
	"""
	var counter = 0
	for line in get_tree().get_nodes_in_group("lines"):
		if line.is_colliding() != collidingCheck[counter]:
			check+=1
		collidingCheck[counter] = line.is_colliding()
		counter+=1
	if check > 0:
		collision()
	"""
	
	for line in get_tree().get_nodes_in_group("lines"):
		if line.is_colliding():
			isColliding = true
			#collision()
		else: 
			check+=1
	if check == count:
		pass
		#new_circle()
	




func _on_visible_area_body_entered(body):
	#print("god please work")
	pass # Replace with function body.


func _on_visible_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	tileBeGone.emit(body_rid)


func _on_visible_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	tileBeBack.emit(body_rid)

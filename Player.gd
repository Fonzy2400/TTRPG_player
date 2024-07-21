extends MoveableObject2D
#@export var stringName: String
var count
var radius
var isColliding = false
signal tileBeGone
signal tileBeBack
var collidingCheck = []
var prevSelected = false
signal tileChanged


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	player_name_handler()
	var circ = $rotateCircle
	circ.monitoring = false
	if get_parent().name == "World":
		connect("tileBeGone",get_parent().fuck_up_that_tile)
		connect("tileBeBack",get_parent().restore_that_tile)
	#create_feelers()
	#collision()

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	#if selected:
		#$Label.text = "selected"
	#else:
		#$Label.text = "not selected"
	if selected != prevSelected:
		if selected:
			create_feelers()
	if(!selected):
		var points = PackedVector2Array([])
		for child in $LinesBin.get_children():
			$LinesBin.remove_child(child)
		$Shape.set_polygon(points)
	if rotatable == true:
		rotatable = false
	
	

func collision():
	var points = PackedVector2Array([])
	for line in $LinesBin.get_children():
		if line.is_colliding():
			points.append(line.get_collision_point()-position)
		else:
			points.append(line.target_position)
	$Shape.set_polygon(points)

		
func new_circle():
	var points = PackedVector2Array([])
	for line in $LinesBin.get_children():
		points.append(line.target_position)
	#$visibleArea/CollisionPolygon2D.set_polygon(points)
	$Shape.set_polygon(points)

func _physics_process(delta):
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
	#for line in $LinesBin.get_children():
		#if line.is_colliding():	
			#tileBeBack.emit(line.correctRID)
	prevSelected = selected
	if (selected):
		for line in $LinesBin.get_children():
			if line.is_colliding():
				isColliding = true
				collision()
			else: 
				check+=1
		if check == count:
			pass
			new_circle()
	
func create_feelers():
	var ray = load("res://my_ray.tscn")
	var points = PackedVector2Array([])
	count = 50
	radius = 198
	for i in range(count):
		var line = ray.instantiate()
		line.set_collision_mask(4)
		$LinesBin.add_child(line)
		var point = radius*Vector2(cos(i*2*PI/count),sin(i*2*PI/count))
		#need to move them slightly away from each other so they don't just all detect at zero.
		line.target_position = point
		#fakeLine.target_position = point2
	
func player_name_handler():
		if nameString == "Chardoney":
			$sprite.region_rect = Rect2(48,96,48,48)
			$sprite.scale = Vector2(0.33,0.33)
			$rotateCircle.scale = Vector2(0.5,0.5)
			$grabCircle.scale = Vector2(0.5,0.5)
		if nameString == "Aellys":
			$sprite.region_rect = Rect2(0,96,48,48)
			$sprite.scale = Vector2(0.33,0.33)
			$rotateCircle.scale = Vector2(0.5,0.5)
			$grabCircle.scale = Vector2(0.5,0.5)
		if nameString == "Nico":
			$sprite.region_rect = Rect2(96,96,48,48)
			$sprite.scale = Vector2(0.5,0.5)
			$rotateCircle.scale = Vector2(0.5,0.5)
			$grabCircle.scale = Vector2(0.5,0.5)
		if nameString == "Temeris":
			$sprite.region_rect = Rect2(144,96,48,48)
			$sprite.scale = Vector2(0.33,0.33)
			$rotateCircle.scale = Vector2(0.5,0.5)
			$grabCircle.scale = Vector2(0.5,0.5)
		if nameString == "Sylvir":
			$sprite.region_rect = Rect2(192,96,48,48)
			$sprite.scale = Vector2(0.33,0.33)
			$rotateCircle.scale = Vector2(0.5,0.5)
			$grabCircle.scale = Vector2(0.5,0.5)
		if nameString == "Avaleigh":
			$sprite.region_rect = Rect2(0,160,48,48)
			$sprite.scale = Vector2(0.33,0.33)
			$rotateCircle.scale = Vector2(0.5,0.5)
			$grabCircle.scale = Vector2(0.5,0.5)


func _on_visible_area_body_entered(body):
	#print("god please work")
	pass # Replace with function body.


func _on_visible_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	tileBeBack.emit(body_rid)


func _on_visible_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass
	#tileBeBack.emit(body_rid)


func _on_magic_eraser_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	tileBeGone.emit(body_rid)

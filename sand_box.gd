extends MoveableObject2D



func _ready():
	super._ready()
	
	
	var count = 50
	var radius2 = 300
	var radius1 = 100
	for i in range(count):
		var test = RayCast2D.new()
		var test2 = RayCast2D.new()
		var point2 = radius2*Vector2(cos(i*2*PI/count),sin(i*2*PI/count))
		var point1 = radius1*Vector2(cos(i*2*PI/count),sin(i*2*PI/count))
		test.position = point2
		test.set_target_position(-point1)
		test2.set_target_position(point1)
		add_child(test)
		add_child(test2)


extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	circle(20)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func circle(radius):
	var circlePoints = nSidedPoly(200,radius,false)
	set_polygon(circlePoints)
	pass
func nSidedPoly(sides,radius,preset):
	var incrementAngle = 2*PI/sides #calculates angle to rotate by to generate N regular polygons units in radians
	var rootPoint = Vector2(0,1) #will always generate first point with distance one along x axis
	var points = PackedVector2Array([])
	var count = 0
	var totalAngle = 0
	#generate PackedVector2Array of points for polygon
	for side in range(sides): #rotate by total angle and generate new point
		var newPoint = radius*Vector2(cos(totalAngle),sin(totalAngle)) #sin and cos inherently radians
		points.append(newPoint)
		totalAngle += incrementAngle
	#return list of points for set_poly()
	return points

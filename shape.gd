#create a system such that the DM can add basic shape overlays
#basic structure 
	#Will have the movable object quality (still need to include scale options)
	#instead of pixel art assets, pre-generated polygons will be used.
	#Keep in mind that 5ft = 16 pixels for now. Convert accordingly
extends Polygon2D
#declare global variables here
@onready var obj = get_parent() #adding moveable object node for rotation and movement control
@onready var pixelScale = 16



# Called when the node enters the scene tree for the first time.
func _ready():
	color = Color(0.8,0.2,0.2,0.5)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func triangle():
	pass
func square(length): #create square with given side length
	var squarePoints = nSidedPoly(4,length/5*16/sqrt(2),true) 
	set_polygon(squarePoints)
	rotate(PI/4)
	#obj.add_child(square)
	obj.get_node("GrabCircle/grabber").scale = Vector2(length*5/16,length*5/16)
	obj.get_node("RotateCircle/rotater").scale = Vector2(length*5/16,length*5/16)
func cone(length):
	color = Color(0.8,0.2,0.2,0.5)
	#according to D&D rules the cone is an isoscles right triangle
	#create base 45,45,90 triangle with standard dimensions
	var points = PackedVector2Array([Vector2(0,0),
									Vector2(0,sqrt(2)*length*pixelScale/5),
									Vector2(sqrt(2)*length*pixelScale/5,0)])
	set_polygon(points)
	#create circle for rotation node of spell casting cone
	var circle = Polygon2D.new()
	var circlePoints = nSidedPoly(200,5,false)
	circle.set_polygon(circlePoints)
	circle.color = Color(0.8,0.2,0.2)
	get_parent().add_child.call_deferred(circle)
	
	pass
func circle():
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
		

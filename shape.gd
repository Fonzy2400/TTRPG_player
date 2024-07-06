#create a system such that the DM can add basic shape overlays
#basic structure 
	#Will have the movable object quality (still need to include scale and rotation options)
	#instead of pixel art assets, pre-generated polygons will be used.
	#Keep in mind that 5ft = 16 pixels for now. Convert accordingly
extends Node2D
#declare global variables here
@onready var obj = $"Movable Object"
@onready var pixelScale = 16


# Called when the node enters the scene tree for the first time.
func _ready():
	cone(15)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func triangle():
	pass
func square():
	pass
func cone(length):
	#according to D&D rules the cone is an isoscles right triangle
	#create base 45,45,90 triangle with standard dimensions
	var poly = Polygon2D.new()
	var points = PackedVector2Array([Vector2(0,0),
									Vector2(0,sqrt(2)*length*pixelScale/5),
									Vector2(sqrt(2)*length*pixelScale/5,0)])
	poly.set_polygon(points)
	obj.add_child(poly)
	pass
func circle():
	pass

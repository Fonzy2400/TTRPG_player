extends MenuButton
#Menu Button is really weird. Has an internal popup menu that can only be accessed internally in script

# Called when the node enters the scene tree for the first time.
func _ready():
	var popup = get_popup() #need to grab popup menu to be able to address our buttons
	popup.connect("id_pressed",_on_id_pressed) #connecting this signal gives us our item ID which we can handle from there


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_id_pressed(id):
	idHandler(id)
	
	
func idHandler(id):
	#just a few if statements corresponding to the different shapes
	# (0,square), (1,circle), (2,cone), (3, line)
	if(id==0):
		square()
	if(id==1):
		circle()
	if(id==2):
		cone()


func square():
	var loadSquare = load("res://shape.tscn")
	var square = loadSquare.instantiate()
	$"../..".add_child(square)
	square.position = $"../..".get_global_mouse_position()
	$"../..".move_child(square,2)
	var shape = square.get_node("shape")
	shape.square(5)
	
func cone():
	var loadCone = load("res://shape.tscn")
	var cone = loadCone.instantiate()
	cone.position = get_global_mouse_position()
	$"../..".add_child(cone)
	cone.position = $"../..".get_global_mouse_position()
	$"../..".move_child(cone,2)
	var shape = cone.get_node("shape")
	shape.cone(10)
	
func circle():
	var loadCircle = load("res://shape.tscn")
	var circle = loadCircle.instantiate()
	circle.position = get_global_mouse_position()
	$"../..".add_child(circle)
	circle.position = $"../..".get_global_mouse_position()
	$"../..".move_child(circle,2)
	var shape = circle.get_node("shape")
	shape.circle(5)

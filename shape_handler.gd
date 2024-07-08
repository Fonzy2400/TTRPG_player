extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_square_button_pressed():
	var loadSquare = load("res://shape.tscn")
	var square = loadSquare.instantiate()
	square.position = get_global_mouse_position()
	get_parent().add_child(square)
	get_parent().move_child(square,2)
	var shape = square.get_node("shape")
	shape.square(5)
	#get_parent().add_child(square)


func _on_cone_button_pressed():
	var loadCone = load("res://shape.tscn")
	var cone = loadCone.instantiate()
	cone.position = get_global_mouse_position()
	get_parent().add_child(cone)
	get_parent().move_child(cone,2)
	var shape = cone.get_node("shape")
	shape.cone(10)
	


func _on_circle_button_pressed():
	var loadCircle = load("res://shape.tscn")
	var circle = loadCircle.instantiate()
	circle.position = get_global_mouse_position()
	get_parent().add_child(circle)
	get_parent().move_child(circle,2)
	var shape = circle.get_node("shape")
	shape.circle(5)

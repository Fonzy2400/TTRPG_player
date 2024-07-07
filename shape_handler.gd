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
	square.held = true
	get_parent().add_child(square)
	var shape = square.get_node("shape")
	shape.square(10)
	#get_parent().add_child(square)


func _on_cone_button_pressed():
	pass # Replace with function body.


func _on_circle_button_pressed():
	pass # Replace with function body.

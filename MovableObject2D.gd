class_name MoveableObject2D 	extends Node2D
@export var nameString: String
var clickable = false #boolean for whether or not an object can be picked up. Is triggered by mouse entering collision
var rotatable = false #tracks whether object can be rotated
var rotating = false #tracks whether an object is rotating or not
var held = false #boolean for while an object is held
var selected = false #tracks if this is the last object selected
signal pickedUp #signal emitted to main handler to turn off other objects while object is held
signal putDown #signal emiited to main handler to resume other objects after object is set down
signal canRotate #signal to tell cursor to update
signal noRotate #signal to tell cursor to return to normal
signal startRotate
signal endRotate
var previousMousePosition #needed for calculationg mouse angular velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	var grabCircle = Area2D.new()
	grabCircle.name = "grabCircle"
	add_child(grabCircle)
	var grabber = CollisionShape2D.new()
	grabber.name = "grabber"
	$grabCircle.add_child(grabber)
	var circle = CircleShape2D.new()
	circle.radius = 10
	$grabCircle/grabber.shape = circle
	grabCircle.connect("mouse_entered",_on_area_2d_mouse_entered)
	grabCircle.connect("mouse_exited",_on_area_2d_mouse_exited)
	var sprite = Sprite2D.new()
	sprite.name = "sprite"
	sprite.texture = load("res://Pixel art/D&D assets.png") #sprites generated as atlas map
	sprite.region_enabled = true #allows a selection of a part of image
	sprite.texture_filter = TEXTURE_FILTER_NEAREST # fixes blur on pixel art (why is this not the default?!)
	var rect = name_handler() # selects sprite region and scale based off of name of movable object
	sprite.region_rect = rect
	add_child(sprite)
	var rotateCircle = Area2D.new()
	rotateCircle.name = "rotateCircle"
	add_child(rotateCircle)
	var rotator = CollisionShape2D.new()
	rotator.name = "rotator"
	$rotateCircle.add_child(rotator)
	circle = CircleShape2D.new()
	circle.radius = 14
	$rotateCircle/rotator.shape = circle
	$rotateCircle/rotator.scale = $grabCircle/grabber.scale
	rotateCircle.connect("mouse_entered",_on_rotate_circle_mouse_entered)
	rotateCircle.connect("mouse_exited",_on_rotate_circle_mouse_exited)

	#$RotateCircle/rotater.scale = $GrabCircle/grabber.scale
	#connect signals to main game handler only if the main game handler exists. 
	#This allows scenes to be run by themselves
	if get_parent().name == "World":
		connect("pickedUp",get_parent()._on_picked_up)
	if get_parent().name == "World":
		connect("putDown",get_parent()._on_put_down)
	if get_parent().name == "World":
		connect("canRotate",$"../cursor"._on_can_rotate)
	if get_parent().name == "World":
		connect("noRotate",$"../cursor"._on_no_rotate)
	if get_parent().name == "World":
		connect("startRotate",$"../cursor"._on_start_rotate)
	#all movable objects are part of group Movables, this allows for functions to be called on the group all at once
	add_to_group("Movables")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#refer to input map for inputs, although names should be self explanatory
	#When the mouse is inside of an object's collision it can be clicked
	if(Input.is_action_just_pressed("leftClick") and clickable):
		held = true
		selected = true
		pickedUp.emit() #handler turns off all other objects
	if(Input.is_action_pressed("scaleUp") and selected):
		scale+=Vector2(0.05,0.05)
	if(Input.is_action_pressed("scaleDown") and selected):
		scale+=-Vector2(0.05,0.05)
	#until mouse button is let go, object is attached to mouse
	if (held):
		position = get_global_mouse_position()
	#when mouse button let go, places object
	if(Input.is_action_just_released("leftClick") and held):
		held = false
		putDown.emit() # turns all other objects back on
	#while mouse in outside circle rotation is allowed
	if(rotating):
		#rotates object at same rate as mouse moves around asset
		var rotationAngle = previousMousePosition.angle_to(get_local_mouse_position())
		rotate(rotationAngle)
		previousMousePosition = get_local_mouse_position()
	if(Input.is_action_just_pressed("leftClick") and rotatable):
		#sets previous mouse position to calculate angle
		previousMousePosition = get_local_mouse_position() 
		rotating = true
		startRotate.emit()
	if(Input.is_action_just_released("leftClick")):
		rotatable = false
		rotating = false
		endRotate.emit()
	if(Input.is_action_just_pressed("delete") and selected):
		get_parent().remove_child(self)

		
		
#signals to talk to Area2D node
func _on_area_2d_mouse_entered():
	clickable = true
	rotatable = false
	noRotate.emit()


func _on_area_2d_mouse_exited():
	if(!held):
		clickable = false 
		rotatable = true
		canRotate.emit()
		
func _on_rotate_circle_mouse_entered():
	rotatable = true
	canRotate.emit()



func _on_rotate_circle_mouse_exited():
	if(!rotating):
		rotatable = false
		noRotate.emit()
	
	
#manually set the visuals for each "moveable object" in sprite sheet. There's probably better ways to do this?
func name_handler():
	var rect
	if nameString == "":
		rect = Rect2(0,0,0,0)
	if nameString == "ranged kobold":
		rect = Rect2(160,0,16,16)
		scale = Vector2(1,1)
	if nameString == "melee kobold":
		rect = Rect2(144,0,16,16)
		scale = Vector2(1,1)
	if nameString == "magic kobold":
		rect = Rect2(176,0,16,16)
		scale = Vector2(1,1)
	if nameString == "giant spider":
		rect = Rect2(192,0,32,32)
		$grabCircle/grabber.scale = Vector2(2,2)
	#example explanation, applies to all entries
	if nameString == "blue wyrmling":
		rect = Rect2(0,16,64,64) #selects visual from atlas
		scale = Vector2(0.5,0.5) #sets size of visual
		$grabCircle/grabber.scale = Vector2(2,2) #sets size of collision box for picking up
	if nameString == "red wyrmling":
		$grabCircle/grabber.scale = Vector2(2,2)
		rect = Rect2(64,32,64,64)
		scale = Vector2(0.5,0.5)
	if nameString == "tile":
		rect = Rect2(0,0,16,16)
	return rect



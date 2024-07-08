#TODO: 
#Occassionally multiple nontouching assets rotate for no reason??? fix that.
#Need ability to delete any movable object (probably pretty easy?)

extends Node2D
@export var nameString: String
var clickable = false #boolean for whether or not an object can be picked up. Is triggered by mouse entering collision
var rotatable = false #tracks whether object can be rotated
var rotating = false #tracks whether an object is rotating or not
var held = false #boolean for while an object is held
var selected = false #tracks if this is the last object selected
var rect #defines region for visual asset
signal pickedUp #signal emitted to main handler to turn off other objects while object is held
signal putDown #signal emiited to main handler to resume other objects after object is set down
signal canRotate #signal to tell cursor to update
signal noRotate #signal to tell cursor to return to normal
signal startRotate
signal endRotate
var previousMousePosition #needed for calculationg mouse angular velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = load("res://Pixel art/D&D assets.png") #sprites generated as atlas map
	$Sprite2D.region_enabled = true #allows a selection of a part of image
	$Sprite2D.texture_filter = TEXTURE_FILTER_NEAREST # fixes blur on pixel art (why is this not the default?!)
	name_handler() # selects sprite region and scale based off of name of movable object
	$Sprite2D.region_rect = rect
	$RotateCircle/rotater.scale = $GrabCircle/grabber.scale
	#connect signals to main game handler only if the main game handler exists. 
	#This allows scenes to be run by themselves
	var parent = get_parent()
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
	if nameString == "":
		rect = Rect2(0,0,0,0)
	if nameString == "bow kobold":
		rect = Rect2(160,0,16,16)
		scale = Vector2(1,1)
	if nameString == "sword kobold":
		rect = Rect2(144,0,16,16)
		scale = Vector2(1,1)
	if nameString == "mage kobold":
		rect = Rect2(176,0,16,16)
		scale = Vector2(1,1)
	if nameString == "giant spider":
		rect = Rect2(192,0,32,32)
		$"GrabCircle"/grabber.scale = Vector2(4,4)
	#example explanation, applies to all entries
	if nameString == "blue wyrmling":
		rect = Rect2(0,16,64,64) #selects visual from atlas
		scale = Vector2(0.5,0.5) #sets size of visual
		$"GrabCircle"/grabber.scale = Vector2(6,6) #sets size of collision box for picking up
	if nameString == "red wyrmling":
		$"GrabCircle"/grabber.scale = Vector2(6,6)
		rect = Rect2(64,32,64,64)
		scale = Vector2(0.5,0.5)
	if nameString == "tile":
		rect = Rect2(0,0,16,16)
		







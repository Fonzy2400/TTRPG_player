extends Node2D
@export var nameString: String
var clickable = false #boolean for whether or not an object can be picked up. Is triggered by mouse entering collision
var held = false #boolean for while an object is held
var rect #defines region for visual asset
signal pickedUp #signal emitted to main handler to turn off other objects while object is held
signal putDown #signal emiited to main handler to resume other objects after object is set down

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = load("res://Pixel art/D&D assets.png") #sprites generated as atlas map
	$Sprite2D.region_enabled = true #allows a selection of a part of image
	$Sprite2D.texture_filter = TEXTURE_FILTER_NEAREST # fixes blur on pixel art (why is this not the default?!)
	name_handler() # selects sprite region and scale based off of name of movable object
	$Sprite2D.region_rect = rect
	#connect signals to main game handler
	if get_parent()!=null:
		connect("pickedUp",get_parent()._on_picked_up)
	if get_parent()!=null:
		connect("putDown",get_parent()._on_put_down)
	#all movable objects are part of group Movables, this allows for functions to be called on the group all at once
	add_to_group("Movables")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#refer to input map for inputs, although names should be self explanatory
	#When the mouse is inside of an object's collision it can be clicked
	if(Input.is_action_just_pressed("leftClick") and clickable):
		held = true
		pickedUp.emit() #handler turns off all other objects
	#until mouse button is let go, object is attached to mouse
	if (held):
		position = get_global_mouse_position()
	#when mouse button let go, places object
	if(Input.is_action_just_released("leftClick") and held):
		held = false
		putDown.emit() # turns all other objects back on
#signals to talk to Area2D node
func _on_area_2d_mouse_entered():
	clickable = true


func _on_area_2d_mouse_exited():
	if(!held):
		clickable = false 
#manually set the visuals for each "moveable object" in sprite sheet. There's probably better ways to do this?
func name_handler():
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
		$Area2D/CollisionShape2D.scale = Vector2(4,4)
	#example explanation, applies to all entries
	if nameString == "blue wyrmling":
		rect = Rect2(0,16,64,64) #selects visual from atlas
		scale = Vector2(0.5,0.5) #sets size of visual
		$Area2D/CollisionShape2D.scale = Vector2(6,6) #sets size of collision box for picking up
		$Area2D/CollisionShape2D.position = Vector2(-4,-4) #sets offset from center if needed
	if nameString == "red wyrmling":
		$Area2D/CollisionShape2D.scale = Vector2(6,6)
		$Area2D/CollisionShape2D.position = Vector2(4,4)
		rect = Rect2(64,32,64,64)
		scale = Vector2(0.5,0.5)
		

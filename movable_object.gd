extends Node2D
@export var nameString: String
var clickable = false
var held = false
var rect 
signal pickedUp
signal putDown

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = load("res://Pixel art/D&D assets.png")
	$Sprite2D.region_enabled = true
	$Sprite2D.texture_filter = TEXTURE_FILTER_NEAREST
	name_handler()
	$Sprite2D.region_rect = rect
	if get_parent()!=null:
		connect("pickedUp",get_parent()._on_picked_up)
	if get_parent()!=null:
		connect("putDown",get_parent()._on_put_down)
	add_to_group("Movables")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("leftClick") and clickable):
		held = true
		pickedUp.emit()
	if (held):
		position = get_global_mouse_position()
		
	if(Input.is_action_just_released("leftClick") and held):
		held = false
		print("I was put down!")
		putDown.emit()

func _on_area_2d_mouse_entered():
	clickable = true


func _on_area_2d_mouse_exited():
	if(!held):
		clickable = false 
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
	if nameString == "blue wyrmling":
		rect = Rect2(0,16,64,64)
		scale = Vector2(0.5,0.5)
	if nameString == "red wyrmling":
		rect = Rect2(64,32,64,64)
		scale = Vector2(0.5,0.5)
		

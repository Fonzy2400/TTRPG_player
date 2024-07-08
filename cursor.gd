extends Sprite2D
@onready var camera = $"../Camera2D"
var rotating = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delta):
	position = get_global_mouse_position()
	scale = Vector2(1,1)/camera.zoom.x
	if(Input.is_action_just_released("leftClick") and rotating):
		rotating = false
		reset_mouse()
	get_parent().move_child(self,-1)


func _on_can_rotate():
	if(!rotating):
		region_rect = Rect2(240,32,16,16)
		scale = scale*2

func _on_no_rotate():
	if(!rotating):
		reset_mouse()
	
func _on_start_rotate():
	rotating = true

func reset_mouse():
	region_rect = Rect2(224,0,32,32)
	scale = scale/2

extends Camera2D
var velocity = 15/zoom.x
var zvelocity = 0.5
var scrolling = false
var timer = 0
var mouseCam
var lastMousePosition



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scrolling:
		timer += delta
	if mouseCam:
		var movement = get_local_mouse_position() - lastMousePosition
		self.position += -movement.normalized()*15/ceil(zoom.x)
	if Input.is_action_just_released("zoomIn"):
		#move camera towards mouse as it zooms in.
		#print("starting pos "+str(get_global_mouse_position()))
		#print("starting zoom "+str(zoom))
		if !scrolling:
			position = get_global_mouse_position()
			print("scrolling started")
		scrolling = true
		self.zoom.x += zvelocity
		self.zoom.y += zvelocity
	if Input.is_action_just_released("zoomOut"):
		self.zoom.x += -2*zvelocity
		self.zoom.y += -2*zvelocity
		#self.position = get_global_mouse_position()
	if timer > 0.5:
		scrolling = false
		timer=0
	if Input.is_action_just_pressed("grabCamera"):
		mouseCam = true
		lastMousePosition = get_local_mouse_position()
	if Input.is_action_just_released("grabCamera"):
		mouseCam = false
	if Input.is_action_pressed("cameraUp"):
		self.position.y +=-velocity
	if Input.is_action_pressed("cameraDown"):
		self.position.y +=velocity
	if Input.is_action_pressed("cameraLeft"):
		self.position.x +=-velocity
	if Input.is_action_pressed("cameraRight"):
		self.position.x +=velocity
	if zoom.x < 0.5:
		zoom = Vector2(0.5,0.5)
	if zoom.x >15:
		zoom = Vector2(15,15)

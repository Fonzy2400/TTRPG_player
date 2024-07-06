extends Camera2D
#Camera system heavily inspired by camera in multiple visual softwares:
#Features:
	#wasd or arrow key control
	#zoom using scroll wheel
	#can move using center mouse button
#TODO: this is still buggy, zooming in is NOT smooth is going to require some work in future.
#	   camera drag using center mouse button is still bad

var velocity = 15/zoom.x #movement speed of camera due to movement keys, divided by zoom scale to keep scrolling even
var zvelocity = 0.5 #how fast camera zooms in and out
var scrolling = false #detects whether user is zooming using mousewheel
var timer = 0
var mouseCam # detects if camera is grabbed by user using center mouse button
var lastMousePosition # useful for calculating where to move camera while being grabbed by mouse



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scrolling: #if there's a long enough pause while zooming in camera will refocus to new mouse position
		timer += delta #increments timer each frame
	if mouseCam:
		var movement = get_local_mouse_position() - lastMousePosition #calculates direction to move camera
		self.position += -movement.normalized()*15/ceil(zoom.x) #moves camera, velocity scaled by zoom
	#have to use "just_released" for scroll wheel specifically, there is no "action_is_pressed"
	#because technically you can't hold down the mouse button so have to create our own jack action_is_pressed with 
	#a timer 
	if Input.is_action_just_released("zoomIn"): 
		#only if we just barely started zooming do we want to change position of camera, this makes it so that when
		#you zoom in you stay relatively on target to where mouse originally was on map.
		if !scrolling:
			position = get_global_mouse_position()
		scrolling = true
		self.zoom.x += zvelocity
		self.zoom.y += zvelocity
		#zoom out just changes zoom scale at linear rate, no need to move camera
	if Input.is_action_just_released("zoomOut"):
		self.zoom.x += -2*zvelocity
		self.zoom.y += -2*zvelocity
		#self.position = get_global_mouse_position()
	#when timer expires, allows camera to focus on mouse again while zooming in
	if timer > 0.5:
		scrolling = false
		timer=0
	#when user pushes in center mouse button, they can "drag" camera
	if Input.is_action_just_pressed("grabCamera"):
		mouseCam = true
		lastMousePosition = get_local_mouse_position()
	#when user stops pushing center mouse button, stop moving camera
	if Input.is_action_just_released("grabCamera"):
		mouseCam = false
	#camera moves according to directional keys or wasd
	if Input.is_action_pressed("cameraUp"):
		self.position.y +=-velocity
	if Input.is_action_pressed("cameraDown"):
		self.position.y +=velocity
	if Input.is_action_pressed("cameraLeft"):
		self.position.x +=-velocity
	if Input.is_action_pressed("cameraRight"):
		self.position.x +=velocity
	#for some reason clamp() function didn't work, this keeps zoom within acceptable limits
	if zoom.x < 0.5:
		zoom = Vector2(0.5,0.5)
	if zoom.x >15:
		zoom = Vector2(15,15)

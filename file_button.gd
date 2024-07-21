extends Button
signal filePressed
var fileName


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = fileName
	pass


func _on_pressed():
	filePressed.emit(fileName)

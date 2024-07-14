extends LineEdit
var initiative


# Called when the node enters the scene tree for the first time.
func _ready():
	var string = text
	#print(string.get_slice("penis",2))
	var stringSlice = text.substr(0,2)
	var numString = int(stringSlice)
	var number = int(numString)
	initiative = number
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

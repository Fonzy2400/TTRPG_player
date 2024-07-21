extends LineEdit
var initiative
signal our_text_changed


# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	connect("text_submitted",_on_text_submitted)
	connect("text_submitted",$"../.."._text_submitted)
	var string = text
	name = string
	var stringSlice = text.substr(0,2)
	var numString = int(stringSlice)
	var number = int(numString)
	initiative = number
	select()
	grab_focus()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _on_text_submitted(newText):
	var string = text
	name = string
	var stringSlice = text.substr(0,2)
	var numString = int(stringSlice)
	var number = int(numString)
	initiative = number


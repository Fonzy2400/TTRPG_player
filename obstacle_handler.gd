extends MenuButton


func _ready():
	var popup = get_popup() #need to grab popup menu to be able to address our buttons
	popup.connect("id_pressed",_on_id_pressed) #connecting this signal gives us our item ID which we can handle from there


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_id_pressed(id):
	pass

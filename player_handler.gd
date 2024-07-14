extends MenuButton
var nameString

func _ready():
	var popup = get_popup() #need to grab popup menu to be able to address our buttons
	popup.connect("id_pressed",_on_id_pressed) #connecting this signal gives us our item ID which we can handle from there


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_id_pressed(id):
	var string = idHandler(id)
	var enemyFile = load("res://player.tscn")
	var enemy = enemyFile.instantiate()
	enemy.nameString = string
	if $"../.."!=null:
		$"../..".add_child(enemy)
		enemy.position = $"../..".get_global_mouse_position()
	else:
		add_child(enemy)
		enemy.position = get_global_mouse_position()


	
	
func idHandler(id):
	var string = null
	if(id==0):
		string = "Avaleigh"
	if(id==1):
		string = "Chardoney"
	if (id==2):
		string = "Aellys"
	if (id==3):
		string = "Temeris"
	if (id==4):
		string = "Nico"
	if(id==5):
		string = "Sylvir"
		
	return string

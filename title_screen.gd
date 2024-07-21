extends Control
var dir = DirAccess.open("res://Worlds/")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	$PlayButton.pressed.disconnect(_on_play_button_pressed) #button can only be pressed once.
	#var box = VBoxContainer.new()
	#add_child(box)
	var fileNames = dir.get_files()
	#for the next bit we'll assume that only files are ever stored in worlds
	#we want to remove the .tscn at the end for gui purposes
	#code should be similar to player handler
	for fileName in fileNames:
		var newLength = len(fileName)-5
		var newName = fileName.substr(0,newLength)
		var loadFileButton = load("res://file_button.tscn")	
		var button = loadFileButton.instantiate()
		button.fileName = newName
		$FileContainer/Files.add_child(button)
		button.filePressed.connect(_on_file_button_pressed)
		
func _on_file_button_pressed(string):
	var fileName = string + ".tscn"
	var path = "res://Worlds/" + fileName
	#print(path)
	#var newScene = load(path)
	get_tree().change_scene_to_file(path)
	
	
	

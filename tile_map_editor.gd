#tilemaps can be jpeg or png
extends Node2D
var dir = DirAccess.open("res://TileMaps/")
var nameDict = {} #dictionary of readable names and file paths

# Called when the node enters the scene tree for the first time.
func _ready():
	var fileNames = dir.get_files()
	for fileName in fileNames:
		if(fileName.get_extension()=="jpeg"
		or fileName.get_extension()=="png"):
			nameDict[file_path_to_readable(
							fileName.get_basename())
					]= fileName
	print(nameDict.keys())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func file_path_to_readable(path):
	var count = path.get_slice_count("_") 
	if count!=0: #delete underscores and return readable file name
		var readable = ""
		for i in count:
			if i < count-1:
				readable += path.get_slice("_",i)+" "
			if i == count-1:
				readable += path.get_slice("_",i)
		return(readable)
	else:
		return path #if there's no underscores in file name no need to fix
	
	pass
func file_readable_to_path(readable):
	pass

extends Button

func _process(delta):
	if(self.pressed):
		clear()
		get_tree().change_scene("res://scenes/Loader.tscn")



func clear():
	var dir = Directory.new()
	dir.open("user://lang")
	dir.list_dir_begin()
	var f = dir.get_next()
	while not(f == ""):
		if not(f == "." or f == ".."):
			dir.remove(f)
		f = dir.get_next()
	dir.remove("user://options/lang.settings")
	dir.remove("user://options/runner.settings")
	dir.remove("user://options/updater.settings")
	dir.remove("user://data/resources.list")
	dir.remove("user://options/version.settings")

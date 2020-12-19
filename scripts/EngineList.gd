extends Node2D

var resources = null
var installed = null

func _ready():
	OS.window_borderless = false
	OS.window_size.x = 1000
	OS.window_size.y = 600
	var s = OS.get_screen_size()
	var w = OS.get_window_size()
	OS.set_window_position(s*0.5 - w*0.5)
	read_source()
func make_dir(path):
	var dir = Directory.new()
	if not(dir.dir_exists(path)):
		dir.make_dir(path)
func read_file(path, type):
	var data = null
	var file = File.new()
	var dir = Directory.new()
	if(dir.file_exists(path)):
		file.open(path, File.READ)
		if(type == "json"):
			data = parse_json(file.get_line())
		elif(type == "table"):
			data = [parse_json(file.get_line())]
		elif(type == "var"):
			data = file.get_var()
		else:
			data = file.get_as_text()
		file.close()
	return data
func write_file(path, type, data):
	var file = File.new()
	file.open(path, File.WRITE)
	if(type == "json"):
		var json = parse_json(data)
		file.store_line(json)
	elif(type == "var"):
		file.store_var(data)
	else:
		file.store_line(data)
	file.close()

func read_source():
	resources = read_file("res://data/resources.list", "var")
	installed = read_file("user://data/installed.list", "var")
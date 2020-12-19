extends ItemList

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
			data = to_json(file.get_line())
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
var list = []
func _ready():
	self.clear()
	var data = read_file("user://data/installed.list", "var")
	var tick = 0
	while not(tick == data.size()):
		if(OS.get_name() == "X11"):
			list += [{"file_name":data[tick].version, "path":data[tick].path}]
		add_item(data[tick].version, load("res://textures/godot.png"), true)
		tick += 1

	

func _on_ItemList_item_selected(index):
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Run").sltd = list[index]
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Remove").sltd = list[index]
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Run").reload()
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Remove").reload()
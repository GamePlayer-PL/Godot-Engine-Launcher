extends Button


func _process(delta):
	if(self.pressed):
		get_node("GUI").visible = true
		get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI").visible = false
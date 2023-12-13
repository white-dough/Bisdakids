extends TextureRect

func _ready():
	pass

func _get_drag_data(at_position):
	var data : Dictionary = {}
	data["name"] = get_name()
	data["texture"] = texture
	data["node"] = self
	data["group_node"] = get_parent()
	data["next_group"] = get_node("../../" + "AnswerFld" + str(int(str(get_parent().get_name()).get_slice("AnswerFld",1)) + 1)) 
	print(data["next_group"])
	#drag preview
	var drag_preview = load("res://scenes/game/boss_stages/DragPreview.tscn").instantiate()
	drag_preview.texture = get_texture()
	add_child(drag_preview)
	return data
	
#func _can_drop_data(at_position, data):
#	if target.get_name() == get_name():
#		return true
#	return false
#
#func _drop_data(at_position, data):
#	target.texture = get_texture()

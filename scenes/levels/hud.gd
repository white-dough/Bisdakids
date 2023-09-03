extends Control
#@onready var object_list_container = $ColorRect/Panel/ContainerHUD/Objectlist

func object_list_label(current_objects: Array):
	var object_list_container = $ColorRect/Panel/ContainerHUD/Objectlist
	for i in range(object_list_container.get_child_count()):
		var current_label = object_list_container.get_child(i)
		current_label.set_text(current_objects[i])

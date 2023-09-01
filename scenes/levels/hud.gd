extends Control
#@onready var object_list_container = $ColorRect/Panel/ContainerHUD/Objectlist

func object_list_label(current_objects):
	var object_list_container = $ColorRect/Panel/ContainerHUD/Objectlist
#	print(object_list_container)
	
	for i in range(object_list_container.get_child_count()):
		var substring = current_objects[i].to_string().split(":",true,1)
		var label = substring[0]
		object_list_container.get_child(i).set_text(label)


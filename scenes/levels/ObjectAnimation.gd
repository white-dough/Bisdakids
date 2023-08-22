extends Node2D


#func animate_object():
#	var object_found_tween: Tween = create_tween().set_parallel(true)
##	object_found_tween.tween_property()

func _on_objects_object_found(object_name: Area2D):
	print(object_name)
	var object_animation = object_name.get_child(1).duplicate()
	$BaseObject.add_child(object_animation)

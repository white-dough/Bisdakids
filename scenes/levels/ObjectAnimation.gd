extends Node2D


func animate_object():
	var object_found_tween: Tween = create_tween()
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(2,2),1)
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1,1),1)
	

func _on_objects_object_found(object_name: Area2D):
	print(object_name)
	var object_animation = object_name.duplicate()
	self.add_child(object_animation)
	animate_object()

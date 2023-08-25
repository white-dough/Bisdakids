extends Node2D

func animate_object():
	#delete object
	#animate scale modako, nya add particles, position to HUD text label
	var object_found_tween: Tween = create_tween()
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.02,1.02),0.1)
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.035,1.035),0.2)
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.05,1.05),0.3)
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.08,1.08),0.4)
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.1,1.1),0.5)
	#delete queue free

func _on_objects_object_found(object_name: Area2D):
	print(object_name)
	var object_animation = object_name.duplicate()
	self.add_child(object_animation)
	for i in range(3):
		animate_object()

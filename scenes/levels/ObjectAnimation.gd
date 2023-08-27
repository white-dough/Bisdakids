extends Node2D

#delete object
#animate scale modako, nya add particles, position to HUD text label

#func _after_animate_remove(object_name):
	#object_name.queue_free()

func animate_object():
	var object_found_tween: Tween = create_tween()
	# basically these 5 'tweens' will play in sequence (sunod2, murag frame if nag animate)
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.1,1.1), 0.2) # has 4 parameters (object, property, final_val, duration)
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.2,1.2), 0.2)
	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.3,1.3), 0.2)
	#object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.2,1.2), 0.2)
	#object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.3,1.3), 0.2)
	#object_found_tween.finished.connect(object_name.queue_free())
	object_found_tween.finished.connect(self.get_child(0).queue_free)

func _on_objects_object_found(object_name: Area2D):
	print(object_name) # prints the object being clicked
	var object_animation = object_name.duplicate()
	self.add_child(object_animation)
	object_name.queue_free() # remove 
	for i in range(3):
		animate_object() # calls the function above





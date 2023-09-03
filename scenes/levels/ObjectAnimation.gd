extends Node2D

@onready var tween_queue: Array = []

func animate_object(object_to_animate):
	var object_found_tween: Tween = create_tween()
	# basically these 5 'tweens' will play in sequence (sunod2, murag frame if nag animate)
#	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.1,1.1), 0.2) # has 4 parameters (object, property, final_val, duration)
#	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.2,1.2), 0.2)
#	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(1.3,1.3), 0.2)
#	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(0.6,0.6), 0.2) # shrinks the clicked object
#	object_found_tween.tween_property(self.get_child(0), "scale", Vector2(0.5,0.5), 0.2) # also shrinks the object
	object_found_tween.tween_property(object_to_animate, "position", Vector2(500, 500), 3) # this line moves the clicked object down
	object_found_tween.finished.connect(object_to_animate.queue_free) # this line of code removes the object 
	
func _on_objects_object_found_signal(object_name):
	var object_to_animate = object_name.duplicate()
	add_child(object_to_animate)
	object_name.queue_free() # remove 
	animate_object(object_to_animate) # calls the function above

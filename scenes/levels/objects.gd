extends Node2D

signal object_found_signal(object_name)


#
#func compare_layer(result: Array) -> Dictionary: # returns a dictionary
#	var top_most: Dictionary = {}
#	if result.size() > 0:
#		top_most = result[0] 
#		var layer_value = top_most["collider"].get_collision_layer() as int
#		for object in result:
#			var current_layer = object["collider"].get_collision_layer() as int
#			if current_layer > layer_value:
#				top_most = object
#				layer_value = current_layer
#	return top_most

#func _unhandled_input(event) -> void:
#	if event.is_action_released("click_primary"):
#
#		get_tree().get_root().set_input_as_handled()
#		var parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
#		parameters.set_position(get_global_mouse_position())
#		parameters.set_collide_with_areas(true)
#		parameters.set_collide_with_bodies(true)
#		var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state # idk what this does
#		var result: Array = space.intersect_point(parameters, 10) # array
##		var object_selected: Dictionary = compare_layer(result)
#		var selected_objects: Array = get_tree().get_root().get_child(0).selected_objects
#		
##		if !object_selected.is_empty() && object_selected["collider"] in selected_objects:
##			object_found.emit(object_selected["collider"])


func _unhandled_input(event):
	if event.is_action_released("click_primary"):		
		var parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
		parameters.set_position(get_global_mouse_position())
		parameters.set_collide_with_areas(true)
		parameters.set_collide_with_bodies(true)
		var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		var shapes: Array = space.intersect_point(parameters, 10)#array of dictionaries
		var results:Array = []#array of Area2D Nodes
		var selected_objects: Array = get_tree().get_root().get_child(0).selected_objects
		for shape in shapes:
			results.append(shape['collider'])#populate array
		var object_found: Area2D = Area2D.new()
		if !results.is_empty():
			object_found = results[0]
			for result in results:
				if result.is_greater_than(object_found):
					object_found = result
		#If the clicked is not empty Area2D and it is in the selected_objects then emit signal
		if object_found.is_visible_in_tree() && object_found in selected_objects:
			object_found_signal.emit(object_found)

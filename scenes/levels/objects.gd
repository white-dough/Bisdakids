extends Node2D

signal object_found_signal(object_name)
@onready var current_objects: Array = []
@onready var selected_objects: Array = get_tree().get_root().get_child(0).select_random_elements(8)

func _process(delta):
	populate_label()

func populate_label():
	while(current_objects.size() < 4):
		if !selected_objects.is_empty():
			current_objects.append(selected_objects.pop_at(0))
	$"../../HUD".object_list_label(current_objects)		
	

func _unhandled_input(event):
	if event.is_action_released("click_primary"):		
		var parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
		parameters.set_position(get_global_mouse_position())
		parameters.set_collide_with_areas(true)
		parameters.set_collide_with_bodies(true)
		var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		var shapes: Array = space.intersect_point(parameters, 10)#array of dictionaries
		var results:Array = []#array of Area2D Nodes		
		for shape in shapes:
			results.append(shape['collider'])#populate array
		var object_found: Area2D = Area2D.new()
		if !results.is_empty():
			object_found = results[0]
			for result in results:
				if result.is_greater_than(object_found):
					object_found = result
		#If the clicked is not empty Area2D and it is in the selected_objects then emit signal
		if object_found.is_visible_in_tree() && object_found in current_objects:
			object_found_signal.emit(object_found)
			current_objects.erase(object_found)
		print(current_objects)

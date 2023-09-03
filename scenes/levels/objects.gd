extends Node2D

signal object_found_signal(object_name)
@onready var current_objects: Array = []
@onready var count_of_objects_to_find: int = 8
@onready var selected_objects: Array = select_random_elements(count_of_objects_to_find)

func _ready():
	populate_current_objects(null)
#	print(selected_objects)
#Function to randomly select the objects to be found in the level
func select_random_elements(count: int) -> Array:
	var objects: Array = self.get_children() # gets the 4 objects (tolda, kumpas, troso, atsa)
	while selected_objects.size() < count: # loops over the objects
		var random_element = objects[randi() % objects.size()]
		if !selected_objects.has(random_element):
			selected_objects.append(random_element)
	return selected_objects

func populate_current_objects(object_found_remove):
	var remove_index: int = current_objects.find(object_found_remove)
	current_objects.remove_at(remove_index) if remove_index > -1 else current_objects.remove_at(0)
	while(current_objects.size() < 4):
		var object_found = selected_objects.pop_front()
		if object_found:
			if remove_index > -1:
#			var substring = object_found.to_string().split(":",true,1)
				current_objects.insert(remove_index, object_found)
			else:
				current_objects.append(object_found)
		else:
			current_objects.append("")
	print(current_objects)
	var current_objects_label:Array = []
	for object in current_objects:
		if typeof(object) != 4:
			var substring = object.to_string().split(":",true,1)
			current_objects_label.append(substring[0])
		else:
			current_objects_label.append("")
	$"../../HUD".object_list_label(current_objects_label)


#Function to handle the click of the user within the gamescene
func _unhandled_input(event):
	if event.is_action_released("click_primary"):
		var parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
		parameters.set_position(get_global_mouse_position())
		parameters.set_collide_with_areas(true)
		parameters.set_collide_with_bodies(true)
		var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		#The code below returns an array of dictionaries of the Area2Ds that has been clicked
		var shapes: Array = space.intersect_point(parameters, 10)
		var results: Array = []
		var object_found: Area2D = Area2D.new() #instatiate clicked object
		#loop to convert from array of dictionary to array of Area2Ds
		for shape in shapes:
			results.append(shape['collider'])
		#Process to get only the topmost object
		if !results.is_empty():
			object_found = results[0]
			for result in results:
				if result.is_greater_than(object_found):
					object_found = result
		print(object_found)
		if object_found.is_visible_in_tree() && object_found in current_objects:
			#animate, remove from current objects, remove label, replace label
			object_found_signal.emit(object_found)
			populate_current_objects(object_found)

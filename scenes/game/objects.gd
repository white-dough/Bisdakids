extends Node2D

signal object_found_signal(object_name)

@onready var current_objects: Array = []; var count_of_objects_to_find: int; var selected_objects: Array; var history_current_objects: Array = []
var click_abuse_counter: int
var click_abuse_max: int = 5

func _on_level_ready():
	count_of_objects_to_find = $"..".count_of_objects_to_find
	selected_objects = select_random_elements(count_of_objects_to_find)
	populate_current_objects(null)
	var click_abuse_reset_timer: Timer = Timer.new(); click_abuse_reset_timer.wait_time = 3;
	add_child(click_abuse_reset_timer)
	click_abuse_reset_timer.start()
	click_abuse_reset_timer.timeout.connect(reset_click_abuse_counter)
	timer.timeout.connect(remove_taps)

#Function to randomly select the objects to be found in the level
func select_random_elements(count: int) -> Array:
	var objects: Array = $Objects.get_children()
	while selected_objects.size() < count: # loops over the objects
		var random_element = objects[randi() % objects.size()]
		if !selected_objects.has(random_element):
			selected_objects.append(random_element)
	return selected_objects

func populate_current_objects(object_found_remove):
	var remove_index: int = current_objects.find(object_found_remove)
	history_current_objects.erase(object_found_remove)
	current_objects.remove_at(remove_index) if remove_index > -1 else null
	while(current_objects.size() < 5):
		var object_found = selected_objects.pop_front()
		if object_found:
			history_current_objects.append(object_found)#no need to maintain order so no ifelse needed
			#extra conditions to maintain order
			if remove_index > -1:
				current_objects.insert(remove_index, object_found)
			else:
				current_objects.append(object_found)
		else:
			current_objects.append("")
	var current_objects_strings:Array = []
	#To string and that string will be passed to the label writer
	for object in current_objects:
		if typeof(object) != 4:
			var substring = object.to_string().split(":",true,1)
			current_objects_strings.append(substring[0])
		else:
			current_objects_strings.append("")
	$"../HUD".object_list_label(current_objects_strings)
	$"../HUD".current_objects = current_objects
	$"../HUD".history_current_objects = history_current_objects

@onready var timer = $HandleTaps/Timer
#Function to handle the click of the user within the gamescene
func _unhandled_input(event):
	if event.is_action_released("click_primary"):
		var parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
		parameters.set_position(get_global_mouse_position())
		parameters.set_collide_with_areas(true)
		parameters.set_collide_with_bodies(true)
		var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		#The code below returns an array of Area2Ds that has been clicked
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
		#if the objectclicked is what we are looking for, vs if the object is not included
		if object_found.is_visible_in_tree() && object_found in current_objects:
			#animate, remove from current objects, remove label, replace label
			object_found_signal.emit(object_found)
			populate_current_objects(object_found)
		else:
			click_abuse_counter += 1
			if click_abuse_counter > click_abuse_max:
				timer.start()
				#print('start')
				$HandleTaps.show()
				

func reset_click_abuse_counter():
	click_abuse_counter = 0
			
#func _process(delta):
#	print(selected_objects)

	

func remove_taps():
	print('hidden')
	$HandleTaps.hide()



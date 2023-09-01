extends Node2D

#var selected_objects: Array = []
var count_of_objects_to_find: int = 30

func _ready():
	select_random_elements(count_of_objects_to_find)

func select_random_elements(count:int) -> Array:
	var selected_objects: Array = []
	var objects: Array = $GameScene/Objects.get_children() # gets the 4 objects (tolda, kumpas, troso, atsa)
	while selected_objects.size() < count: # loops over the objects
		var random_element = objects[randi() % objects.size()]
		if !selected_objects.has(random_element):
			selected_objects.append(random_element)
	return selected_objects

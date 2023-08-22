extends Node2D

var selected_objects: Array = []
var count_of_objects_to_find: int = 2

func _ready():
	select_random_elements(count_of_objects_to_find)

func select_random_elements(count) -> void:
	var objects: Array = $GameScene/Objects.get_children()
	while selected_objects.size() < count:
		var random_element = objects[randi() % objects.size()]
		if !selected_objects.has(random_element):
			selected_objects.append(random_element)

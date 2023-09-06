extends Control
signal clue_pressed(object_clue)
@onready var object_list_container: VBoxContainer = $ColorRect/Panel/ContainerHUD/Objectlist
@onready var history_current_objects: Array = []

func object_list_label(current_objects_strings: Array, history_current_objects: Array):
	for i in range(object_list_container.get_child_count()):
		var current_label = object_list_container.get_child(i)
		current_label.set_text(current_objects_strings[i])
	self.history_current_objects = history_current_objects

func _on_clue_pressed():
	if not history_current_objects.is_empty():
		clue_pressed.emit(history_current_objects[0])

extends Control
@onready var object_list_container: VBoxContainer = $ColorRect/Panel/ContainerHUD/Objectlist

func _ready():
	for i in range(object_list_container.get_child_count()):
		object_list_container.get_child(i).set_text("trial") 
		

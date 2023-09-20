extends Control

signal clue_pressed(object_clue)

@onready var object_list_container: VBoxContainer = $ColorRect/Panel/ContainerHUD/Objectlist
@onready var history_current_objects: Array = []
@onready var current_objects: Array = []
@onready var level_time: float
@onready var timer: Timer = $ColorRect/Panel/ContainerHUD/TimerBar/Timer
@onready var progress_bar: TextureProgressBar = $ColorRect/Panel/ContainerHUD/TimerBar/ProgressBar

func _on_level_1_ready():
	level_time = $"..".level_time
	progress_bar.max_value = level_time
	progress_bar.set_use_rounded_values(true)
	timer.set_one_shot(true)
	timer.set_wait_time(level_time)
	timer.start()

func _process(_delta):
	progress_bar.value = timer.get_time_left()
	
func object_list_label(current_objects_strings: Array):
	for i in range(object_list_container.get_child_count()):
		var current_label = object_list_container.get_child(i)
		current_label.set_text(current_objects_strings[i])

func _on_clue_pressed():
	if not history_current_objects.is_empty():
		clue_pressed.emit(history_current_objects.pop_front())
	else:
		clue_pressed.emit(current_objects.pick_random())

func _on_timer_timeout():
	pass



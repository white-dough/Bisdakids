extends Control

signal clue_pressed(object_clue)

@onready var object_list_container: VBoxContainer = $ColorRect/Panel/ContainerHUD/Objectlist
@onready var history_current_objects: Array = []
@onready var current_objects: Array = []
@onready var level_time: float
@onready var timer: Timer = $ColorRect/Panel/ContainerHUD/TimerBar/Timer
@onready var pause_timer: Timer = $"TimeFreeze/PauseTimer"
@onready var progress_bar: TextureProgressBar = $ColorRect/Panel/ContainerHUD/TimerBar/ProgressBar

func _on_level_1_ready():
	level_time = $"..".level_time
	progress_bar.max_value = level_time
	progress_bar.set_use_rounded_values(true)
	timer.set_one_shot(true)
	timer.set_wait_time(level_time)
	timer.start()
	pause_timer.timeout.connect(time_freeze)
	

func _process(_delta):
	progress_bar.value = timer.get_time_left()
#	print(current_objects_strings)
	
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
	
func _on_time_freeze_pressed():
	if pause_timer.is_stopped():
		pause_timer.start()
		time_freeze()

func time_freeze():
	var time_froze_sprite = $ColorRect/Panel/ContainerHUD/TimerBar/TimeFroze
	if timer.is_paused():
		timer.set_paused(false)
#		time_froze_sprite.visible = time_froze_sprite.visible 
	else:
		timer.set_paused(true)
		time_froze_sprite.visible = not time_froze_sprite.visible 
	print(pause_timer.is_stopped())
	if pause_timer.is_stopped():
		time_froze_sprite.visible = not time_froze_sprite.visible 
	

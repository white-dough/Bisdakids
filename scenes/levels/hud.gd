extends Control

signal clue_pressed(object_clue)

@onready var object_list_container: VBoxContainer = $ColorRect/Panel/ContainerHUD/Objectlist
@onready var history_current_objects: Array = []
@onready var current_objects: Array = []
@onready var level_time: float
@onready var timer: Timer = $ColorRect/Panel/ContainerHUD/TimerBar/Timer
@onready var pause_timer: Timer = $"TimeFreeze/PauseTimer"
@onready var progress_bar: TextureProgressBar = $ColorRect/Panel/ContainerHUD/TimerBar/ProgressBar

# word description on longpress
@onready var description_container: VBoxContainer = $ColorRect/Panel/CanvasLayer/DescContainer

# para long press feature
const LONG_PRESS_DURATION = 1.5 # in seconds

var pressed = false # para long press feature
var press_time = 0 # para long press feature

func _on_level_1_ready():
	level_time = $"..".level_time
	progress_bar.max_value = level_time
	progress_bar.set_use_rounded_values(true)
	timer.set_one_shot(true)
	timer.set_wait_time(level_time)
	timer.start()
	pause_timer.timeout.connect(time_freeze)
	#lasdas.onclick.connect(time_freeze(label))

func _process(_delta):
	progress_bar.value = timer.get_time_left()
	# print(current_objects_strings)
	# para long press feature
	if pressed:
		press_time += _delta
		if press_time >= LONG_PRESS_DURATION:
			pressed = false
			press_time = 0
	
func object_list_label(current_objects_strings: Array):
	var data = get_definition()
	for i in range(object_list_container.get_child_count()):
		var current_label = object_list_container.get_child(i)
		var desc_label = description_container.get_child(i)
		current_label.set_text(current_objects_strings[i])
		if data.has(current_objects_strings[i]):
			print('1')
			desc_label.set_text(data[current_objects_strings[i]])
		else:
			print("0")

# this function gets the data from words-beta.json (defintion of the words)
func get_definition() -> Dictionary:
	var jsonFile = FileAccess.open("res://words-beta.json", FileAccess.READ)
	var contentOfFile = jsonFile.get_as_text()
	jsonFile.close()
	
	var content_as_dictionary = JSON.parse_string(contentOfFile)
	#var level1 = content_as_dictionary.level1[0].Troso
	return content_as_dictionary.level1[0]
	#var level2 = content_as_dictionary.level2[0]
	#var level3 = content_as_dictionary.level3[0]
	# etc until level5...

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
	if timer.is_paused():
		timer.set_paused(false)
		print("timer is paused, unpaused")
	else:
		timer.set_paused(true)
		print("timer is not paused, pausing")

# on longpress description feature
func _on_label_1_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			pressed = true
			press_time = 0
			var label_name = "Label1"
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = true
		elif event.button_index == MOUSE_BUTTON_LEFT:
			pressed = false
			var label_name = "Label1"
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = false

func _on_label_2_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			pressed = true
			press_time = 0
			var label_name = "Label2"
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = true
		elif event.button_index == MOUSE_BUTTON_LEFT:
			pressed = false
			var label_name = "Label2"
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = false

func _on_label_3_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			pressed = true
			press_time = 0
			var label_name = "Label3" 
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = true
		elif event.button_index == MOUSE_BUTTON_LEFT:
			pressed = false
			var label_name = "Label3" 
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = false

func _on_label_4_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			pressed = true
			press_time = 0
			var label_name = "Label4" 
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = true
		elif event.button_index == MOUSE_BUTTON_LEFT:
			pressed = false
			var label_name = "Label4"
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = false

func _on_label_5_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			pressed = true
			press_time = 0
			var label_name = "Label5"
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = true
		elif event.button_index == MOUSE_BUTTON_LEFT:
			pressed = false
			var label_name = "Label5" 
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = false

extends CanvasLayer

signal clue_pressed(object_clue)
signal level_finished(time_finished:float)

@onready var object_list_container: VBoxContainer = $ColorRect/Panel/ContainerHUD/Objectlist
@onready var history_current_objects: Array = []
@onready var current_objects: Array = []
@onready var level_time: float
@onready var timer: Timer = $ColorRect/Panel/ContainerHUD/TimerBar/Timer
@onready var timer_lbl: Label = $ColorRect/Panel/ContainerHUD/TimerBar/TimeLbl
@onready var pause_timer: Timer = $"TimeFreeze/PauseTimer"
@onready var progress_bar: TextureProgressBar = $ColorRect/Panel/ContainerHUD/TimerBar/ProgressBar
@onready var level_success
# word description on longpress
@onready var description_container: CanvasLayer = $ColorRect/Panel/CanvasLayer

@onready var finish_level_mark: int

# para long press feature
const LONG_PRESS_DURATION = 1.5 # in seconds

var pressed = false # para long press feature
var press_time = 0 # para long press feature

func _on_level_ready():
	set_labels()
	label_definitions() # function para sa word defintion (long press)
	level_time = $"..".level_time
	progress_bar.max_value = level_time
	progress_bar.set_use_rounded_values(true)
	timer.set_one_shot(true)
	timer.set_wait_time(level_time)
	timer.start()
	pause_timer.timeout.connect(time_freeze)
	level_success = $"../LevelCompleted"
func _process(_delta):
	progress_bar.value = timer.get_time_left()
	# print(current_objects_strings)
	# para long press feature
	if pressed:
		press_time += _delta
		if press_time >= LONG_PRESS_DURATION:
			pressed = false
			press_time = 0
	timer_lbl.text = "%d:%02d" % [floor(timer.time_left / 60), int(timer.time_left) % 60]
	
func object_list_label(current_objects_strings: Array):
	var data = get_definition()
	for i in range(object_list_container.get_child_count()):
		var current_label = object_list_container.get_child(i)
		var desc_label = description_container.get_child(i)
		current_label.set_text(current_objects_strings[i])
		if data.has(current_objects_strings[i]):
			#print('1')
			desc_label.set_text(data[current_objects_strings[i]])
		else:
			finish_level_mark += 1
			#why 15? idk its supposed to be 5, signifying that all 5 labels are empty
			if finish_level_mark >= 15:
				var time_finished: float = timer.time_left
				level_finished.emit(time_finished)
			
# this function gets the data from words-beta.json (defintion of the words)
func get_definition() -> Dictionary:
	var jsonFile = FileAccess.open("res://data/words-beta.json", FileAccess.READ)
	var contentOfFile = jsonFile.get_as_text()
	jsonFile.close()
	
	var content_as_dictionary = JSON.parse_string(contentOfFile)
	var dataToBePassed
	
	var parentNode = str(get_parent().get_scene_file_path())
	var level = $"..".level_name
	
	match(level):
		"level1":
			dataToBePassed = content_as_dictionary.level1
		"level2":
			dataToBePassed = content_as_dictionary.level2
		"level3":
			dataToBePassed = content_as_dictionary.level3
		"level4":
			dataToBePassed = content_as_dictionary.level4
		"level5":
			dataToBePassed = content_as_dictionary.level5
	return dataToBePassed
	#var level2 = content_as_dictionary.level2[0]
	#var level3 = content_as_dictionary.level3[0]
	# etc until level5...

func _on_clue_pressed():
	if int(Game.user_inventory['hint']) > 0:
		Audio.play_sfx(Audio.hint_sfx)
		use_hint()
		Game.user_inventory['hint'] = int(Game.user_inventory['hint']) - 1
		Game.user_inventory['hint_timestamp'] = Time.get_unix_time_from_system()
		Game.update_local_save()
		set_labels()

func use_hint():
	if not history_current_objects.is_empty():
		clue_pressed.emit(history_current_objects.pop_front())
	else:
		clue_pressed.emit(current_objects.pick_random())

func set_labels():
	var hint_lbl: Label = $ColorRect/Panel/ContainerHUD/Clue/HintLbl
	var time_freeze_lbl: Label = $TimeFreeze/TimeFreezeLbl
	hint_lbl.set_text(str(Game.user_inventory['hint']))
	time_freeze_lbl.set_text(str(Game.user_inventory['time_freeze']))
	
func _on_timer_timeout():
	if level_success.visible:
		return
	level_finished.emit(0)
	
func _on_time_freeze_pressed():
	if int(Game.user_inventory['time_freeze']) > 0:
		if pause_timer.is_stopped():
			pause_timer.start()
			time_freeze()
			Game.user_inventory['time_freeze'] = int(Game.user_inventory['time_freeze']) - 1
			Game.user_inventory['time_freeze_timestamp'] = Time.get_unix_time_from_system()
			Game.update_local_save()
			set_labels()
	

func time_freeze():
	Audio.play_sfx(Audio.freeze_sfx)
	var time_froze_sprite = $ColorRect/Panel/ContainerHUD/TimerBar/TimeFroze
	if timer.is_paused():
		timer.set_paused(false)
#		time_froze_sprite.visible = time_froze_sprite.visible 
	else:
		timer.set_paused(true)
		time_froze_sprite.visible = not time_froze_sprite.visible 
	if pause_timer.is_stopped():
		time_froze_sprite.visible = not time_froze_sprite.visible 
		print("timer is not paused, pausing")

func label_definitions():
	#var positionY = [90, 190, 255, 320, 400]
	var parentContainer: VBoxContainer = $ColorRect/Panel/ContainerHUD/Objectlist
	for i in range(parentContainer.get_child_count()):
		var label = parentContainer.get_child(i)
		#print(positionY[i])
		var labelName = "Label" + str(i+1)
		#print(labelName)
		label.gui_input.connect(word_def_display.bind(labelName)) # labelName, position y

func word_def_display(event, labelName):
	if event is InputEventMouseButton:
		Audio.play_sfx(Audio.book_flip_sfx)
		if event.pressed:
			pressed = true
			press_time = 0
			var label_name = labelName
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = true
				#desc_label.position.y = pos
		elif event.button_index == MOUSE_BUTTON_LEFT:
			pressed = false
			var label_name = labelName
			var desc_label = description_container.get_node(label_name)
			if desc_label:
				desc_label.visible = false


func _on_settings_pressed():
	var settings_scene : PackedScene = load("res://scenes/navigation/settings_gameplay/settings_gameplay.tscn")
	Audio.play_sfx(Audio.wood_btn_sfx)
	add_child(settings_scene.instantiate())
	

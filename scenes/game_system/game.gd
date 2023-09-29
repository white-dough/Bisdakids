extends Node

@onready var player_data_path: String = "user://player_save.dat"
@onready var user_name
@onready var progress: Dictionary = {}
@onready var user_inventory: Dictionary = {}
@onready var daily_task: Dictionary = {}
@onready var current_date : Dictionary = {}
@onready var loaded_player_data : Dictionary = {}

func check_is_connected_internet() -> bool:
	var http = HTTPClient.new()
	http.connect_to_host("www.example.com", 443)
	for i in 5:
		http.poll()
		if not OS.has_feature("web"):
			OS.delay_msec(100)
	return true if http.get_status() == 5 else false
	
##########
func save_data():
	var file: FileAccess = FileAccess.open(player_data_path, FileAccess.WRITE)
	var player_data: Dictionary = create_data()
	file.store_var(player_data)

func create_data() -> Dictionary:
	var player_data: Dictionary = {
		"user_name" : user_name,

		"progress" : progress,

		"user_inventory" : user_inventory,

		"daily_task" : daily_task
	}
	return player_data

func load_data():
	var file: FileAccess = FileAccess.open(player_data_path, FileAccess.READ)
	var file_exists: bool = FileAccess.file_exists(player_data_path)
	if not file_exists:
		save_data()
	loaded_player_data = file.get_var()
	user_name = loaded_player_data['user_name']
	progress = loaded_player_data['progress']
	user_inventory = loaded_player_data['user_inventory']
	daily_task = loaded_player_data['daily_task']
		
#########

func daily_task_reset():
	daily_task = {}
	var jsonFile : FileAccess = FileAccess.open("res://data/daily_task.json", FileAccess.READ)
	var contentOfFile : String = jsonFile.get_as_text()	
	var content_as_dictionary : Dictionary = JSON.parse_string(contentOfFile)
	var keys = content_as_dictionary.keys()  # Get the keys of the original dictionary
	jsonFile.close()
	keys.shuffle()  # Shuffle the keys to randomize the selection
	# Select the first 3 shuffled keys and add them to the selectedItems dictionary
	for i in range(3):
		var key = keys[i]
		daily_task[key] = content_as_dictionary[key]
	daily_task["unix_datestamp"] = Time.get_unix_time_from_system()

func daily_task_logic():#returns true if a day ahead
	if !daily_task.is_empty():
		var daily_task_unix_datestamp = daily_task["unix_datestamp"]
		var system_current_unix_datestamp = Time.get_unix_time_from_system()
		var timeDifference = system_current_unix_datestamp - daily_task_unix_datestamp
		if timeDifference < 86400:
			return
	daily_task_reset()
###

func _ready():
	load_data()
	daily_task_logic()
#	check_is_connected_internet()
	
#	var test = {"progress" : progress}
#	print(create_data())

func _process(_delta):
	if Engine.get_process_frames () % 3600 == 0:
		daily_task_logic()

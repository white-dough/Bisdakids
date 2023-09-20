extends Node

@onready var player_data_path: String = "user://player_save.dat"
@onready var user_id = null #should be either null or int
@onready var progress: Dictionary = {}
@onready var user_inventory: Dictionary = {}
@onready var daily_task: Dictionary = {"Detective": "Find 15 hidden objects.", "Energy Spend": "Use 50 energy points.", "Level Finish": "Finish a level.", "unix_datestamp": 1694970530.192}
@onready var current_date : Dictionary

func is_connected_internet() -> bool:
	var http = HTTPClient.new() # Create the Client.
	http.connect_to_host("www.pornhub.com", 443)
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		print("Connecting...")
		if not OS.has_feature("web"):
			OS.delay_msec(500)
	return true if http.get_status() == 5 else false
	
##########
func save_data():
	var file: FileAccess = FileAccess.open(player_data_path, FileAccess.WRITE)
	var player_data: Dictionary = create_data()
	file.store_var(player_data)

func create_data() -> Dictionary:
	var player_data: Dictionary = {
		"user_id" : user_id,

		"progress" : progress,

		"inventory" : user_inventory,

		"daily_task" : daily_task
	}
	return player_data

func load_data():
	var file: FileAccess = FileAccess.open(player_data_path, FileAccess.READ)
	var file_exists: bool = FileAccess.file_exists(player_data_path)
	if file_exists:
		var loaded_player_data = file.get_var()
		print(loaded_player_data)
	else:
		save_data()
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
	pass
#	load_data()
#	print(is_connected_internet())
#	save_data()
#	var test = {"progress" : progress}
#	print(create_data())

func _process(delta):
	if Engine.get_process_frames () % 3600 == 0:
		daily_task_logic()
		print(daily_task)

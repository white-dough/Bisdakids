extends Node

@onready var player_data_path: String = "user://player_save.dat"
@onready var user_name
@onready var progress: Dictionary = {}
@onready var user_inventory: Dictionary = {}
@onready var daily_task: Dictionary = {}
@onready var current_date : Dictionary = {}
@onready var loaded_player_data : Dictionary = {}
@onready var http_request : HTTPRequest = HTTPRequest.new()
@onready var is_connected_to_internet : bool = false

func check_is_connected_internet():
	http_request.cancel_request()
	is_connected_to_internet = false
	http_request.request("http://example.com/")

func _on_request_completed(_result, response_code, _headers, _body):
	if (response_code == 200):
		is_connected_to_internet = true
	else:
		is_connected_to_internet = false

##########
func save_data():
	var file: FileAccess = FileAccess.open(player_data_path, FileAccess.WRITE)
	var player_data: Dictionary = create_data()
	file.store_var(player_data)

func create_data() -> Dictionary:
	var player_data: Dictionary = {
		"user_name" : user_name,

		"progress" : progress,

		"user_inventory" : read_user_inventory(),

		"daily_task" : daily_task
	}
	return player_data

func load_data():
	var file_exists: bool = FileAccess.file_exists(player_data_path)
	if not file_exists:
		save_data()
	var file: FileAccess = FileAccess.open(player_data_path, FileAccess.READ)
	loaded_player_data = file.get_var()
	user_name = loaded_player_data['user_name']
	progress = loaded_player_data['progress']
	user_inventory = loaded_player_data['user_inventory']
	daily_task = loaded_player_data['daily_task']
	print(loaded_player_data)
		
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
	var datetime = Time.get_datetime_dict_from_system()
	datetime['hour'] = 0
	datetime['minute'] = 0
	datetime['second'] = 0
	daily_task["unix_datestamp"] = Time.get_unix_time_from_datetime_dict(datetime)
	save_data()

func daily_task_logic():#returns true if a day ahead
	if !daily_task.is_empty():
		var daily_task_unix_datestamp = daily_task["unix_datestamp"]
		var system_current_unix_datestamp = Time.get_unix_time_from_system()
		var timeDifference = system_current_unix_datestamp - daily_task_unix_datestamp
		if timeDifference < 86400:
			return
	daily_task_reset()
###

func read_user_inventory():
	var jsonFile : FileAccess = FileAccess.open("res://data/user_inventory.json", FileAccess.READ)
	var contentOfFile : String = jsonFile.get_as_text()	
	var content_as_dictionary : Dictionary = JSON.parse_string(contentOfFile)
	jsonFile.close()
	return content_as_dictionary
###
func _ready():
	http_request.timeout = 3
	add_child(http_request)
	http_request.connect("request_completed", _on_request_completed)
#	save_data()
	load_data()
	check_is_connected_internet()
	await http_request
	if is_connected_to_internet and user_name != null:
		#query inventory
		PhpRequest.query_inventory(user_name)
		await PhpRequest.http_request
		user_inventory = PhpRequest.clean_response
#	check_is_connected_internet()
#	var test = {"progress" : progress}
#	print(create_data())

func _process(_delta):#change to timerrrrr
	if Engine.get_process_frames () % 3600 == 0:
		daily_task_logic()

extends Node

@onready var player_data_path: String = "user://player_save.dat"
@onready var user_name = "dwight19"
@onready var progress: Dictionary = {}
@onready var user_inventory: Dictionary = {"coin" : 1, "energy" : 2, "premium" : 0, "hint" : 3, "time_freeze" : 4, "timestamp" : 1696484341}
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
#	print("save: " + str(player_data))

func create_data() -> Dictionary:
	var player_data: Dictionary = {
		"user_name" : user_name,

		"progress" : progress,

		"user_inventory" : user_inventory,

		"daily_task" : daily_task
	}
	return player_data

func load_data():
	var file_exists: bool = FileAccess.file_exists(player_data_path)
	if not file_exists:
		save_data()
	var file: FileAccess = FileAccess.open(player_data_path, FileAccess.READ)
	loaded_player_data = file.get_var()
#	print(loaded_player_data)
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



func query_general():
	#
	if user_name:#add verification timestamp later
		PhpRequest.get_user_inventory(user_name)
		await PhpRequest.http_request.request_completed
		for item in PhpRequest.clean_response:
			if float(item['timestamp']) > float(user_inventory['timestamp']):
				user_inventory[item['item_name']] = item['quantity']
				user_inventory['timestamp'] = item['timestamp']
			else:
				PhpRequest.update_user_inventory(user_name, user_inventory)
#		user_inventory['timestamp'] = Time.get_unix_time_from_system()
		save_data()
		
func _ready():
	http_request.timeout = 3
	add_child(http_request)
	http_request.connect("request_completed", _on_request_completed)
	save_data()
	load_data()
	query_general()
	daily_task_logic()
	PhpRequest.update_user_inventory(user_name, user_inventory)
#	print(user_inventory)
	
#		user_inventory = PhpRequest.clean_response
#		var file2: FileAccess = FileAccess.open('res://data/user_inventory.json', FileAccess.WRITE)
#		print(file2.get_var())
#		file.store_var(PhpRequest.clean_response)
#	save_data()
#	print(user_inventory)
#	print(user_inventory)
#	check_is_connected_internet()
#	await http_request
#	if is_connected_to_internet and user_name != null:
#		#query inventory
#		PhpRequest.query_inventory(user_name)
#		await PhpRequest.http_request
#		user_inventory = PhpRequest.clean_response
#	check_is_connected_internet()
#	var test = {"progress" : progress}
#	print(create_data())

func _process(_delta):#change to timerrrrr
#	load_data()
	pass
#	if Engine.get_process_frames () % 3600 == 0:
#		daily_task_logic()

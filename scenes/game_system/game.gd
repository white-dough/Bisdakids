extends Node

@onready var player_data_path: String = "user://player_save.dat"
@onready var user_name = null
@onready var progress_base: Dictionary = {"level1": 0,
									"level2": 0,
									"level3": 0,
									"level4": 0,
									"level5": 0,
									"timestamp":0}
@onready var user_inventory_base: Dictionary = {"coin" : 0, 
										"coin_timestamp": 0,
										"energy": 0,
										"energy_timestamp": 0,
										"premium": 0,
										"premium_timestamp": 0,
										"hint": 0,
										"hint_timestamp": 0,
										"time_freeze": 0,
										"time_freeze_timestamp": 0}
@onready var daily_task_base: Dictionary = {}
@onready var progress: Dictionary = progress_base
@onready var user_inventory: Dictionary = user_inventory_base
@onready var daily_task: Dictionary = daily_task_base
@onready var current_date : Dictionary = {}
@onready var loaded_player_data : Dictionary = {}
@onready var http_request : HTTPRequest = HTTPRequest.new()
@onready var is_connected_to_internet : bool = false
var premium: bool = false

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
#	print(player_data)
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
		content_as_dictionary[key]["progress"] = 0
		daily_task[key] = content_as_dictionary[key]
	var datetime = Time.get_datetime_dict_from_system()
	datetime['hour'] = 0
	datetime['minute'] = 0
	datetime['second'] = 0
	daily_task["unix_datestamp"] = Time.get_unix_time_from_datetime_dict(datetime)
	update_local_save()

func daily_task_logic():#returns true if a day ahead
	if !daily_task.is_empty():
		var daily_task_unix_datestamp = daily_task["unix_datestamp"]
		var system_current_unix_datestamp = Time.get_unix_time_from_system()
		var timeDifference = system_current_unix_datestamp - daily_task_unix_datestamp
		if timeDifference < 86400:
			return
	daily_task_reset()
###

func record_purchase(bundle_id: int):
	PhpRequest.record_purchase(user_name, bundle_id)
#	#invget, progressget, dtget
#	if user_name:#add verification timestamp later
#		PhpRequest.get_user_inventory(user_name)
#		await PhpRequest.http_request.request_completed
#		for item in PhpRequest.clean_response:
#			user_inventory[item] = PhpRequest.clean_response[item]
#		save_data()
		
func query_update():
	if user_name:
		PhpRequest.get_user_inventory(user_name)
		await PhpRequest.http_request.request_completed
		for item in PhpRequest.clean_response:
#			print(item)
			if float(user_inventory[item['item_name'] + '_timestamp']) <= float(item['timestamp']):
				user_inventory[item['item_name']] = item['quantity']
				user_inventory[item['item_name'] + '_timestamp'] = item['timestamp']
				user_inventory.erase('timestamp')
				update_local_save()
			else:
				PhpRequest.update_user_inventory(user_name, user_inventory)
				await PhpRequest.http_request.request_completed

func sync_data():
	var inventory_timestamps: Array = []
	var inventory_timestamp_max: float
	var progress_timestamp: float = float(Game.progress["timestamp"])
	var inventory_items: Dictionary = {}
	var progress_scores: Dictionary = Game.progress.duplicate()
	progress_scores.erase("timestamp")
	for key in user_inventory:
		if key.contains("_timestamp"):
			inventory_timestamps.append(float(Game.user_inventory[key]))
		else:
			inventory_items[key] = Game.user_inventory[key]
	inventory_timestamp_max = inventory_timestamps.max()
	var timestamp =  inventory_timestamp_max if inventory_timestamp_max > progress_timestamp else progress_timestamp
	PhpRequest.sync_data(Game.user_name, timestamp, inventory_items, progress_scores)
	await PhpRequest.http_request.request_completed
	if PhpRequest.clean_response != "db_updated":
		var result: Dictionary = JSON.parse_string(PhpRequest.clean_response)
		Game.user_inventory =  result["user_inventory"]
		Game.progress = result["account_progress"]
		Game.daily_task_reset()
		Game.update_local_save()
		
func get_user_inventory_local() -> Dictionary:
	var user_inventory_clean: Dictionary = {}
	for key in user_inventory:
		if not key.contains("_timestamp"):
			user_inventory_clean[key] = Game.user_inventory[key]
	return user_inventory_clean

func progress_update(level : String, score : int):
	if progress[level] > score:
		return
	progress[level] = score
	PhpRequest.update_account_progress(user_name, int(level), score)
	await PhpRequest.http_request.request_completed

func reset_data():
	Game.user_name = null
	Game.user_inventory = user_inventory_base 
	Game.progress = progress_base
	Game.daily_task = daily_task_base
	update_local_save()

func update_local_save():
	daily_task_logic()
	save_data()
	load_data()

func daily_task_from_db():
	PhpRequest.get_dailyTasks()
	await PhpRequest.http_request.request_completed
	if PhpRequest.api_no_error:
		var file = FileAccess.open("res://data/daily_task.json", FileAccess.WRITE)
		var formattedData = {}
		for data in PhpRequest.clean_response:
			var title = data["task_title"]
			formattedData[title] = {}
			for key in data:
				if key != "task_title":
					formattedData[title][key] = data[key]
#					formattedData[title]["progress"] = 0
		file.store_line(JSON.stringify(formattedData, "\t"))
		file.close()

func _ready():
	http_request.timeout = 3
	add_child(http_request)
	http_request.connect("request_completed", _on_request_completed)
	daily_task_logic()
	load_data()
	premium = true if user_inventory['premium'] else false
	print(loaded_player_data)
	print(premium)
	await daily_task_from_db()
	#timer
#	var file: FileAccess = FileAccess.open(player_data_path, FileAccess.WRITE)
#	var player_data: Dictionary = { "user_name": "dwight19", "progress": { "level1": 4869, "level2": 0, "level3": 0, "level4": 0, "level5": 0, "timestamp": 1697299889.65907 }, "user_inventory": { "coin": 40, "coin_timestamp": 1697299889.77125, "energy": 0, "energy_timestamp": 1697299889.8651, "hint": 13, "hint_timestamp": 1697356638.439, "premium": 0, "premium_timestamp": 1697299890.05594, "time_freeze": 3, "time_freeze_timestamp": 1697356634.596 }, "daily_task": { "Level Finish": { "task_desc": "Finish a level.", "reward": "coin", "reward_quantity": 10, "progress": 0, "goal": 1 }, "Detective": { "task_desc": "Find 15 hidden objects.", "reward": "coin", "reward_quantity": 8, "progress": 10, "goal": 15 }, "Score": { "task_desc": "Collect 5000 score points.", "reward": "coin", "reward_quantity": 15, "progress": 5000, "goal": 5000 }, "unix_datestamp": 1697328000 } }
#	file.store_var(player_data)
#	print("save: " + str(player_data))
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


func texture_logic(item_name:String)->Texture2D:
	match(item_name):
		"time_freeze":
			return load("res://graphics/store_items/TimeFreeze_3.png")
		"hint":
			return load("res://graphics/store_items/hint@2x.png")
		"energy":
			return load("res://graphics/store_items/Energy_3.png")
		"coin":
			return load("res://graphics/ui/icons/coins_icon@2x.png")
		_:
			return load("res://graphics/store_items/mystery@2x.png")

func name_logic(item_name:String)->String:
	match(item_name):
		"time_freeze":
			return "Time Freeze"
		"hint":
			return "Hint"
		"energy":
			return "Energy"
		_:
			return "Mystery Bundle"

func reverse_name_logic(item_name:String)->String:
	match(item_name):
		"Time Freeze":
			return "time_freeze"
		"Hint":
			return "hint"
		"Energy":
			return "energy"
		_:
			return "Mystery Bundle"


func _process(_delta):#change to timerrrrr
#	load_data()
#	daily_task_logic()
#	print(loaded_player_data)
	pass
#	if Engine.get_process_frames () % 3600 == 0:
#		daily_task_logic()

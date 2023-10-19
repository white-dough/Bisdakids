extends Node

var http_request: HTTPRequest = HTTPRequest.new()
#const SERVER_URL = "http://192.168.1.105:8080/godot-php-postgresql/api-request.php"
const SERVER_URL = "http://localhost:8080/godot-php-postgresql/api-request.php"
const SERVER_HEADERS = ["Content-Type: application/x-www-form-urlencoded", "Cache-Control: max-age=0"]
var request_queue : Array = []
var is_requesting : bool = false
var clean_response

func _ready():
	http_request.set_timeout(5.0) 
	add_child(http_request)
	http_request.connect("request_completed", _http_request_completed)
#	store_query()
#	add_user_inventory()

func _process(_delta):
	# Check if we are good to send a request:
	if is_requesting:
		return
	if request_queue.is_empty():
		return
	is_requesting = true
	_send_request(request_queue.pop_front())

func _send_request(request : Dictionary):
	var client = HTTPClient.new()
	var data = client.query_string_from_dict({"data" : JSON.stringify(request['data'])})
#	print(typeof(request['data']))	
	var body = "command=" + str(request['command']) + "&" + data
#	print(JSON.stringify(request['data']))
	# Make request to the server:
	var err = http_request.request(SERVER_URL, SERVER_HEADERS, HTTPClient.METHOD_POST, body)
	# Check if there were problems:
	if err != OK:
		printerr("HTTPRequest error: " + error_string(err))
		return
	# Print out request for debugging:
	print("Requesting...\n\tCommand: " + request['command'] + "\n\tBody: " + body)
	
func get_user_inventory(user_name : String):
	var command = "get_user_inventory"
	var data = {"user_name" : user_name}
	request_queue.push_back({"command" : command, "data" : data});
func update_user_inventory(user_name : String, user_inventory : Dictionary):#item_id: int, quantity: int
	var command = "update_user_inventory"
	var data = {"user_name" : user_name}
	for item in user_inventory:
		data[item] = user_inventory[item]
	request_queue.push_back({"command" : command, "data" : data});
	
func login(user_name : String, password : String):#item_id: int, quantity: int
	var command = "login"
	var data = {"user_name" : user_name, "password": password}
	request_queue.push_back({"command" : command, "data" : data});
func register(user_name : String, password : String):#item_id: int, quantity: int
	var command = "register"
	var data = {"user_name" : user_name, "password": password}
	request_queue.push_back({"command" : command, "data" : data});

func store_query():
	var command = "store_query"
	var data = {}
	request_queue.push_back({"command" : command, "data" : data});
func record_purchase(user_name : String, bundle_id : int):
	var command = "record_purchase"
	var data = {"user_name" : user_name, "bundle_id": bundle_id}
	request_queue.push_back({"command" : command, "data" : data});

func get_user_progress(user_name : String):
	var command = "get_user_progress"
	var data = {"user_name" : user_name}
	request_queue.push_back({"command" : command, "data" : data});
func update_account_progress(user_name : String, level : int, highscore: int):
	var command = "update_account_progress"
	var data = {"user_name": user_name,"level_id": level, "highscore": highscore}
	request_queue.push_back({"command" : command, "data" : data});

func get_dailyTasks():
	var command = "get_dailyTasks"
	var data = {}
	request_queue.push_back({"command" : command, "data" : data});

func sync_data(user_name : String, timestamp : float, user_inventory: Dictionary, account_progress: Dictionary):
	var command = "sync_data"
	var data = {"user_name": user_name,"timestamp": timestamp, "user_inventory": user_inventory, "account_progress": account_progress}
	request_queue.push_back({"command" : command, "data" : data});

func _http_request_completed(result, _response_code, _headers, body):
	is_requesting = false
	if result != HTTPRequest.RESULT_SUCCESS:
		printerr("Connection Error: BisdakidsPOSTGRESQL PHP API")
		clean_response = "ErrPHP"
		return
	var response_body = body.get_string_from_utf8()
	var response
	if not response:
		printerr("BISDAKIDS API IS DOWN: ")
		clean_response = "BISDAKIDS_API_DOWN"
		return
	# Grab our JSON and handle any errors reported by our PHP code:
	response = JSON.parse_string(response_body)
#	print(response['error'])
	
	if response['error'] != "none":
		printerr("BISDAKIDS API ERROR: " + response['error'])
		return
#	print(response)
	request_saving(response)
	
func request_saving(response):
	match response['command']:
		"login":
			if response['response']['query'] == "success":
				clean_response = response['response']['user_name']
			else:
				clean_response = "failed"
		"register":
			if response['response']['query'] == "success":
				clean_response = "success"
			else:
				clean_response = "failed"
		"store_query":
			if typeof(response['response']) == TYPE_STRING:
				clean_response = [response['response']]
			else:
				clean_response = response['response']
		"get_user_inventory":
			if response['response'].size() > 0:
				clean_response = response['response']
			else:
				clean_response = "nodata"
		"update_user_inventory":
			if response['response']['query'] == "success":
				clean_response = "success"
			else:
				clean_response = "failed"
		"get_user_progress":
			if response['response'].size() > 0:
				clean_response = response['response']
			else:
				clean_response = "nodata"
		"update_user_progress":
			if response['response']['query'] == "success":
				clean_response = "success"
			else:
				clean_response = "failed"
		"record_purchase":
			if response['response']['query'] == "success":
				clean_response = "success"
			else:
				clean_response = "failed"
		"sync_data":
			if response['response'].has("progress_update") or response['response'].has("inventory_update"):
				clean_response = "db_updated"
			else:
				clean_response = str(response['response'])
		"get_dailyTasks":
			if typeof(response['response']) == TYPE_STRING:
				clean_response = [response['response']]
			else:
				clean_response = response['response']
#	print(clean_response)

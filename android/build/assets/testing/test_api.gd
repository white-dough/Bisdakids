extends Node

var http_request: HTTPRequest = HTTPRequest.new()
const SERVER_URL = "http://localhost:8080/godot-php-postgresql/api-request.php"
const SERVER_HEADERS = ["Content-Type: application/x-www-form-urlencoded", "Cache-Control: max-age=0"]
var request_queue : Array = []
var is_requesting : bool = false

func _ready():
	add_child(http_request)
	http_request.connect("request_completed", _http_request_completed)
	add_user_inventory()
	
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
	
func get_user_inventory():
	var command = "get_user_inventory"
	var data = {"user_name" : 'dwight'}
	request_queue.push_back({"command" : command, "data" : data});

func add_user_inventory():#item_id: int, quantity: int
	var command = "add_user_inventory"
	var data = {"user_name" : 'dwight', "item_id": 2, "quantity": 29}
	request_queue.push_back({"command" : command, "data" : data});
	
func _http_request_completed(result, _response_code, _headers, body):
	is_requesting = false
	if result != HTTPRequest.RESULT_SUCCESS:
		printerr("Error w/ connection: " + String(result))
		return
	var response_body = body.get_string_from_utf8()
	# Grab our JSON and handle any errors reported by our PHP code:
	var response = JSON.parse_string(response_body)
#	print(response['error'])
	if response['error'] != "none":
		printerr("BISDAKIDS API ERROR: " + response['error'])
		return
	print("Response Body:\n" + str(response))

extends CanvasLayer

@onready var username_input : LineEdit = $LoginPnl/ContentVBox/FirstInputHBox/UsernameInput
@onready var password_input : LineEdit = $LoginPnl/ContentVBox/SecondInputHBox/PasswordInput
@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_in_scene : CanvasLayer  = load("res://scenes/navigation/settings/account_management/loggedIn.tscn").instantiate()
@onready var error_modal = $"../ErrorModal"

func _on_login_btn_pressed():
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	PhpRequest.login(user_name, password)
	await PhpRequest.http_request.request_completed
	if PhpRequest.clean_response != "failed":
		Game.user_name = PhpRequest.clean_response
		Game.save_data()
		queue_free()
		mainmenu_modal_node.add_child(logged_in_scene)
	elif PhpRequest.clean_response == "ErrPHP":
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("DATABASE CONNECTION UNSUCCESSFUL")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Cannot establish a connection to the account processing server. Check your internet and try again.")
		error_modal.visible = true
	else:
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("LOGIN UNSUCCESSFUL")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Account credentials do not match. Please try again.")
		error_modal.visible = true
#	print("hello")


func _on_back_btn_pressed():
	for child in mainmenu_modal_node.get_children():
		if child != error_modal:
			child.queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

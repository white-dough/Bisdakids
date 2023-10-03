extends CanvasLayer

@onready var username_input : LineEdit = $SignupPnl/ContentVBox/FirstInputVBox/UsernameInput
@onready var password_input : LineEdit = $SignupPnl/ContentVBox/SecondInputVBox/PasswordInput
@onready var confirm_password_input : LineEdit = $SignupPnl/ContentVBox/ThirdInputVBox/ConfirmPasswordInput
@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_in_scene : CanvasLayer  = load("res://scenes/navigation/settings/account_management/loggedIn.tscn").instantiate()
@onready var error_modal = $"../ErrorModal"

func _on_signup_btn_pressed():
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	var confirm_password: String = confirm_password_input.get_text()
	if password == confirm_password:
		PhpRequest.register(user_name, password)
		await PhpRequest.http_request.request_completed
		if PhpRequest.clean_response == "success":
			Game.user_name = user_name
			Game.save_data()
			mainmenu_modal_node.get_child(0).queue_free()
			mainmenu_modal_node.add_child(logged_in_scene)
		elif PhpRequest.clean_response == "ErrPHP":
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("DATABASE CONNECTION UNSUCCESSFUL")
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Cannot establish a connection to the account processing server. Check your internet and try again.")
			error_modal.visible = true
		else:
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("SIGNUP UNSUCCESSFUL")
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Username already taken.")
			error_modal.visible = true
	elif !password.is_empty():
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("SIGNUP UNSUCCESSFUL")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Password cannot be blank. Please try again.")
		error_modal.visible = true
	else:
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("SIGNUP UNSUCCESSFUL")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Passwords do not match. Please try again.")
		error_modal.visible = true


func _on_back_btn_pressed():
	for child in mainmenu_modal_node.get_children():
		if child != error_modal:
			child.queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

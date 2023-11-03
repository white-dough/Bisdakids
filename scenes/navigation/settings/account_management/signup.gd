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
			Game.update_local_save()
			await Game.sync_data()
			queue_free()
			mainmenu_modal_node.add_child(logged_in_scene)
		elif PhpRequest.clean_response == "ErrPHP":
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NATARUNG ANG KONEKSIYON SA DATABASE! ")
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Dili mahimo ang koneksiyon sa server sa pagproseso sa kani na akawnt. Susi-a sa ang imong internet ug suwayi usab.")
			error_modal.visible = true                  
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NA BUHAT ANG AKAWNT!")
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Naa nay naggamit ani na username.")
			error_modal.visible = true
	elif !password.is_empty():
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NA BUHAT ANG AKAWNT!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Ang password dili pwede na blangkohan. Palihug suwayi pag-usab.")
		error_modal.visible = true
	else:
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NA BUHAT ANG AKAWNT!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Ang mga password sa akawnt dili magkapareho. Palihug suwayi pag-usab.")
		error_modal.visible = true


func _on_back_btn_pressed():
	for child in mainmenu_modal_node.get_children():
		if child != error_modal:
			child.queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

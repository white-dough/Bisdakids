extends CanvasLayer

@onready var username_input : LineEdit = $SignupPnl/ContentVBox/FirstInputVBox/UsernameInput
@onready var password_input : LineEdit = $SignupPnl/ContentVBox/SecondInputVBox/PasswordInput
@onready var confirm_password_input : LineEdit = $SignupPnl/ContentVBox/ThirdInputVBox/ConfirmPasswordInput
@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_in_scene : CanvasLayer  = load("res://scenes/navigation/settings/account_management/loggedIn.tscn").instantiate()
@onready var error_modal = $"../ErrorModal"

func _on_signup_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	var confirm_password: String = confirm_password_input.get_text()
	var username: String = username_input.get_text()
	if password == confirm_password and !password.is_empty() and !username.is_empty():
		PhpRequest.register(user_name, password)
		await PhpRequest.http_request.request_completed
		if PhpRequest.clean_response == "success":
			Game.user_name = user_name
			Game.update_local_save()
			await Game.sync_data()
			queue_free()
			mainmenu_modal_node.add_child(logged_in_scene)
		elif !PhpRequest.api_no_error:
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALAY TUBAG GIKAN SA SERBER!")
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Palihug pagpailob kanamo samtang amo kinang giayo ang problema sa serber.")
			error_modal.visible = true   
		else:               
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NA BUHAT ANG AKAWNT!")
			$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Naa nay naggamit ani na username.")
			error_modal.visible = true
	elif username.is_empty():
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NA BUHAT ANG AKAWNT!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Ang pangalan dili pwede na blangkohan. Palihug suwayi pag-usab.")
		error_modal.visible = true
	elif password.is_empty() or confirm_password.is_empty():
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NA BUHAT ANG AKAWNT!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Ang password dili pwede na blangkohan. Palihug suwayi pag-usab.")
		error_modal.visible = true
	else:
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NA BUHAT ANG AKAWNT!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Ang mga password sa akawnt dili magkapareho. Palihug suwayi pag-usab.")
		error_modal.visible = true


func _on_back_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	for child in mainmenu_modal_node.get_children():
		if child != error_modal:
			child.queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

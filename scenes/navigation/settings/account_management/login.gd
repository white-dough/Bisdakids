extends CanvasLayer

@onready var username_input : LineEdit = $LoginPnl/ContentVBox/FirstInputHBox/UsernameInput
@onready var password_input : LineEdit = $LoginPnl/ContentVBox/SecondInputHBox/PasswordInput
@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_in_scene : CanvasLayer  = load("res://scenes/navigation/settings/account_management/loggedIn.tscn").instantiate()
@onready var error_modal = $"../ErrorModal"

func _on_login_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	if user_name.strip_edges().is_empty() or password.strip_edges().is_empty():
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("BLANGKO NGA DETALYE!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Dili mahimo nga walay ihatag nga detalye.")
		error_modal.visible = true
		return
	PhpRequest.login(user_name, password)
	await PhpRequest.http_request.request_completed
	if PhpRequest.clean_response != "failed":
		Game.reset_data()
		print(Game.loaded_player_data)
		Game.user_name = PhpRequest.clean_response
		Game.sync_data()#calls the update_local_save for us
		Game.update_local_save()
		queue_free()
		mainmenu_modal_node.add_child(logged_in_scene)
	elif PhpRequest.clean_response == "ErrPHP":
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALA NATARUNG ANG KONEKSIYON SA DATABASE!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Dili mahimo ang koneksiyon sa server sa pagproseso sa kani na akawnt. Susi-a sa ang imong internet ug balik usab.")
		error_modal.visible = true
	else:
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("DILI MAKASULOD SA AKAWNT")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Ang mga kredensiyal sa akawnt dili magkapareho. Palihug suwayi pag-usab.")
		error_modal.visible = true
#	print("hello")


func _on_back_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	for child in mainmenu_modal_node.get_children():
		if child != error_modal:
			child.queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

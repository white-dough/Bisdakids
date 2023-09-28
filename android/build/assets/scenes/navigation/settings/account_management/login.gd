extends CanvasLayer

@onready var username_input : LineEdit = $LoginPnl/ContentVBox/FirstInputHBox/UsernameInput
@onready var password_input : LineEdit = $LoginPnl/ContentVBox/SecondInputHBox/PasswordInput
@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_in_scene : CanvasLayer  = load("res://scenes/navigation/settings/account_management/loggedIn.tscn").instantiate()

func _on_login_btn_pressed():
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	PhpRequest.login(user_name, password)
	await get_tree().create_timer(3).timeout
	if PhpRequest.clean_response != "failed":
		Game.user_name = PhpRequest.clean_response
		Game.save_data()
		mainmenu_modal_node.get_child(0).queue_free()
		mainmenu_modal_node.add_child(logged_in_scene)
		
#	print("hello")


func _on_back_btn_pressed():
	mainmenu_modal_node.get_child(0).queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

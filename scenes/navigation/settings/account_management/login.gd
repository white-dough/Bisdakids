extends CanvasLayer

@onready var username_input : LineEdit = $LoginPnl/ContentVBox/FirstInputHBox/UsernameInput
@onready var password_input : LineEdit = $LoginPnl/ContentVBox/SecondInputHBox/PasswordInput
@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()


func _on_login_btn_pressed():
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	PhpRequest.login(user_name, password)


func _on_back_btn_pressed():
	mainmenu_modal_node.get_child(0).queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

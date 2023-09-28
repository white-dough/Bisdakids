extends CanvasLayer

@onready var username_input : LineEdit = $SignupPnl/ContentVBox/FirstInputVBox/UsernameInput
@onready var password_input : LineEdit = $SignupPnl/ContentVBox/SecondInputVBox/PasswordInput
@onready var confirm_password_input : LineEdit = $SignupPnl/ContentVBox/ThirdInputVBox/ConfirmPasswordInput
@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()

func _on_signup_btn_pressed():
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	var confirm_password: String = confirm_password_input.get_text()
	if password == confirm_password:
		PhpRequest.register(user_name, password)
	else:
		print("pass does not match")


func _on_back_btn_pressed():
	mainmenu_modal_node.get_child(0).queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

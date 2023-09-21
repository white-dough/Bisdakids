extends CanvasLayer

@onready var username_input : LineEdit = $LoginPnl/ContentVBox/FirstInputHBox/UsernameInput
@onready var password_input : LineEdit = $LoginPnl/ContentVBox/SecondInputHBox/PasswordInput



func _on_login_btn_pressed():
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	PhpRequest.login(user_name, password)

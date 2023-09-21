extends CanvasLayer

@onready var username_input : LineEdit = $SignupPnl/ContentVBox/FirstInputVBox/UsernameInput
@onready var password_input : LineEdit = $SignupPnl/ContentVBox/SecondInputVBox/PasswordInput
@onready var confirm_password_input : LineEdit = $SignupPnl/ContentVBox/ThirdInputVBox/ConfirmPasswordInput

func _on_signup_btn_pressed():
	var user_name: String = username_input.get_text()
	var password: String = password_input.get_text()
	var confirm_password: String = confirm_password_input.get_text()
	if password == confirm_password:
		PhpRequest.register(user_name, password)
	else:
		print("pass does not match")

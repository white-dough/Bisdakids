extends CanvasLayer

@onready var mainmenu_modal_node : Control = $"../"
@onready var login_scene = load("res://scenes/navigation/settings/account_management/login.tscn")
@onready var back_btn = $NotLoggedInPnl/BackBtn
@onready var login_btn = $NotLoggedInPnl/ContentVBox/LoginSignupHbox/LoginBtn
@onready var signup_scene = load("res://scenes/navigation/settings/account_management/signup.tscn")
@onready var signup_btn = $NotLoggedInPnl/ContentVBox/LoginSignupHbox/SignupBtn
@onready var modal_btn_pressed = mainmenu_modal_node.modal_btn_pressed

func _ready():
	login_btn.pressed.connect(modal_btn_pressed.bind(login_scene))
	signup_btn.pressed.connect(modal_btn_pressed.bind(signup_scene))
	back_btn.pressed.connect(modal_btn_pressed.bind(mainmenu_modal_node.settings_scene))


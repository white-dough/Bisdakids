extends CanvasLayer

@onready var mainmenu_modal_node : Control = $"../"
@onready var login_scene = load("res://scenes/navigation/settings/account_management/login.tscn")
@onready var back_btn = $NotLoggedInPnl/BackBtn
@onready var login_btn = $NotLoggedInPnl/ContentVBox/LoginSignupHbox/LoginBtn
@onready var signup_scene = load("res://scenes/navigation/settings/account_management/signup.tscn")
@onready var signup_btn = $NotLoggedInPnl/ContentVBox/LoginSignupHbox/SignupBtn
@onready var modal_btn_pressed = mainmenu_modal_node.modal_btn_pressed
#@onready var is_connected_internet : bool

func _ready():
#	is_connected_internet = Game.check_is_connected_internet()
	login_btn.pressed.connect(modal_btn_pressed.bind(login_scene))
	signup_btn.pressed.connect(modal_btn_pressed.bind(signup_scene))
	back_btn.pressed.connect(modal_btn_pressed.bind(mainmenu_modal_node.settings_scene))


#
#func _process(_delta):
#	if Engine.get_process_frames () % 720 == 0:
#		is_connected_internet = Game.check_is_connected_internet()
#		if !is_connected_internet:
#			print("no internet here")
#			call(modal_btn_pressed.bind(mainmenu_modal_node.settings_scene))

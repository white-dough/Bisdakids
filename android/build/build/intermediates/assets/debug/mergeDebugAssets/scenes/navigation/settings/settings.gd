extends CanvasLayer

@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_in_scene : CanvasLayer  = load("res://scenes/navigation/settings/account_management/loggedIn.tscn").instantiate()
@onready var account_button : TextureButton = $SettingsPnl/SettingsVbox/AccountBtn
@onready var is_connected_internet : bool

func _process(_delta):
	if Engine.get_process_frames () % 720 == 0:
		is_connected_internet = Game.check_is_connected_internet()
		account_button.disabled = true if !is_connected_internet else false

func _ready():
	is_connected_internet = Game.check_is_connected_internet()
	account_button.disabled = true if !is_connected_internet else false

func _on_close_btn_pressed():
	queue_free()

func _on_account_btn_pressed():
	var scene_to_render = not_logged_in_scene if Game.user_name == null else logged_in_scene
	mainmenu_modal_node.get_child(0).queue_free()
	mainmenu_modal_node.add_child(scene_to_render)

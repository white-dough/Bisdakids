extends CanvasLayer

@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene : CanvasLayer = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_in_scene : CanvasLayer  = load("res://scenes/navigation/settings/account_management/loggedIn.tscn").instantiate()
@onready var account_button : TextureButton = $SettingsPnl/SettingsVbox/AccountBtn
@onready var is_connected_internet : bool = false
@onready var check_internet_timer : Timer = Timer.new()

func _ready():
	account_button.disabled = true
	check_internet_timer.connect("timeout", check_internet)
	check_internet_timer.wait_time = 1
	add_child(check_internet_timer)
	check_internet_timer.start()

func check_internet():
	Game.check_is_connected_internet()
	await Game.http_request.request_completed
	is_connected_internet = Game.is_connected_to_internet
	account_button.disabled = true if !is_connected_internet else false
	check_internet_timer.start()

func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	queue_free()

func _on_account_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	var scene_to_render = not_logged_in_scene if Game.user_name == null else logged_in_scene
	queue_free()
	mainmenu_modal_node.add_child(scene_to_render)


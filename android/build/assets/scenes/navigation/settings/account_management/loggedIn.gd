extends CanvasLayer

@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene :CanvasLayer  = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_user_label : Label = $LoggedInPnl/ContentVBox/LabelsVBox/LoggedLbl
@onready var error_modal = $"../ErrorModal"

func _ready():
	logged_user_label.set_text(Game.user_name)

func _on_back_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	mainmenu_modal_node.modal_btn_pressed(mainmenu_modal_node.settings_scene)

func _on_logout_btn_pressed():
	#confirm
	Audio.play_sfx(Audio.close_btn_sfx)
	Game.reset_data()
	for child in mainmenu_modal_node.get_children():
		if child != error_modal:
			child.queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

func _on_sync_btn_pressed():#change timestamps to now in order to be in sync with db
	Audio.play_sfx(Audio.normal_btn_sfx)
	await Game.sync_data()
	
	
	
	
	

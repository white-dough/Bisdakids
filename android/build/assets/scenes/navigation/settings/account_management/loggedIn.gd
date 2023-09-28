extends CanvasLayer

@onready var mainmenu_modal_node : Control = $"../"
@onready var not_logged_in_scene :CanvasLayer  = load("res://scenes/navigation/settings/account_management/notLoggedIn.tscn").instantiate()
@onready var logged_user_label : Label = $LoggedInPnl/ContentVBox/LabelsVBox/LoggedLbl

func _ready():
	logged_user_label.set_text(Game.user_name)

func _on_back_btn_pressed():
	mainmenu_modal_node.modal_btn_pressed(mainmenu_modal_node.settings_scene)

func _on_logout_btn_pressed():
	Game.user_name = null
	Game.save_data()
	mainmenu_modal_node.get_child(0).queue_free()
	mainmenu_modal_node.add_child(not_logged_in_scene)

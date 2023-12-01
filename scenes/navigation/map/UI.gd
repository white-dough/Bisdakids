extends CanvasLayer

@onready var settings_scene : PackedScene = load("res://scenes/navigation/map/settings_map.tscn")

func _ready():
	$HBoxContainer/energy_lbl.set_text(str(Game.energy_system['energy']))
	$HBoxContainer/Coin_lbl.set_text(str(Game.user_inventory['coin']))

func _on_home_btn_pressed():
	Audio.play_sfx(Audio.wood_btn_sfx)
	get_tree().change_scene_to_file("res://scenes/navigation/main_menu/main_menu.tscn")

func _on_settings_pressed():
	Audio.play_sfx(Audio.wood_btn_sfx)
	get_parent().add_child(settings_scene.instantiate())

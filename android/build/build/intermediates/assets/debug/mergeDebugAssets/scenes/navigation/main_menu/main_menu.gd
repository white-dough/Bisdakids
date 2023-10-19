extends Node

@onready var energylbl: Label = $Control/HBoxContainer/energy_lbl
@onready var coinlbl: Label  = $Control/HBoxContainer/Coin_lbl

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")

func _ready():
	energylbl.set_text(str(Game.user_inventory['energy']))
	coinlbl.set_text(str(Game.user_inventory['coin']))
	BannerAds.ad_view.show()
	
func _on_modal_child_exiting_tree(_node):
	energylbl.set_text(str(Game.user_inventory['energy']))
	coinlbl.set_text(str(Game.user_inventory['coin']))

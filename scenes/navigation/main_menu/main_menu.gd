extends Node

@onready var energylbl: Label = $Control/HBoxContainer/energy_lbl
@onready var coinlbl: Label  = $Control/HBoxContainer/Coin_lbl

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")

func _ready():
	if Audio.bgm_node.get_stream() != Audio.main_bgm:
		Audio.play_bgm(Audio.main_bgm)
	energylbl.set_text(str(Game.user_inventory['energy']))
	coinlbl.set_text(str(Game.user_inventory['coin']))
	if not Game.premium:
		BannerAds.ad_view.show()
	
func _on_modal_child_exiting_tree(_node):
	energylbl.set_text(str(Game.user_inventory['energy']))
	coinlbl.set_text(str(Game.user_inventory['coin']))


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/credits/credits.tscn")
	pass

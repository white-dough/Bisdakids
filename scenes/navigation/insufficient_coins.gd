extends CanvasLayer

func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	hide()

func _on_dili_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	hide()

func _on_buy_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	get_tree().change_scene_to_file("res://scenes/navigation/main_menu/main_menu_store.tscn")

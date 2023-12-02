extends Node



func _on_texture_button_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	get_tree().change_scene_to_file("res://scenes/navigation/main_menu/main_menu.tscn")

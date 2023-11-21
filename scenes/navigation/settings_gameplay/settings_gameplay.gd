extends CanvasLayer


func _on_home_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	get_tree().change_scene_to_file("res://scenes/navigation/main_menu/main_menu.tscn")

func _on_retry_btn_pressed():
	pass # Replace with function body.

func _on_map_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")


func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	queue_free()

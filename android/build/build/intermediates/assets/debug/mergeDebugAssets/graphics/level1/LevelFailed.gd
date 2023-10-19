extends CanvasLayer


func _on_map_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")

func _on_home_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/main_menu/main_menu.tscn")


func _on_retry_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/game/level1/level_1.tscn")

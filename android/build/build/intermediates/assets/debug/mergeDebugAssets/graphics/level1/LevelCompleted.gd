extends CanvasLayer


func _on_map_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")


func _on_playagain_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/game/level1/level_1.tscn")

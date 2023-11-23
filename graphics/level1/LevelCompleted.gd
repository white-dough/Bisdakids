extends CanvasLayer

func _on_map_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")

func _on_playagain_btn_pressed():
	get_tree().reload_current_scene()

func _on_next_btn_pressed():
	pass # Replace with function body.

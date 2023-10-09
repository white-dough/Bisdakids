extends Node

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")

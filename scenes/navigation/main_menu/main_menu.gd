extends Node

func _on_play_pressed():
	get_tree().change_scene_to_file("res://graphics/map/map.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/settings/settings.tscn")

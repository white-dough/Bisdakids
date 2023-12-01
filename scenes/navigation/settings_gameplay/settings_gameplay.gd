extends CanvasLayer


func _on_home_btn_pressed():
	$"../home_confirm".show()
	if $"../home_confirm/ModalPanel2/Content_Container/yes_btn".is_connected("pressed", to_main_menu):
		$"../home_confirm/ModalPanel2/Content_Container/yes_btn".pressed.disconnect(to_main_menu)
	$"../home_confirm/ModalPanel2/Content_Container/yes_btn".pressed.connect(to_main_menu)

func to_main_menu():
	$"../home_confirm".hide()
	Audio.play_sfx(Audio.normal_btn_sfx)
	get_tree().change_scene_to_file("res://scenes/navigation/main_menu/main_menu.tscn")

func _on_retry_btn_pressed():
	$"../restart_confirm".show()
	if $"../restart_confirm/ModalPanel2/Content_Container/yes_btn".is_connected("pressed", restart_level):
		$"../restart_confirm/ModalPanel2/Content_Container/yes_btn".pressed.disconnect(restart_level)
	$"../restart_confirm/ModalPanel2/Content_Container/yes_btn".pressed.connect(restart_level)

func restart_level():
	$"../restart_confirm".hide()
	Audio.play_sfx(Audio.normal_btn_sfx)
	get_tree().reload_current_scene()

func _on_map_btn_pressed():
	$"../map_confirm".show()
	if $"../map_confirm/ModalPanel2/Content_Container/yes_btn".is_connected("pressed", to_map):
		$"../map_confirm/ModalPanel2/Content_Container/yes_btn".pressed.disconnect(to_map)
	$"../map_confirm/ModalPanel2/Content_Container/yes_btn".pressed.connect(to_map)
func to_map():
	$"../map_confirm".hide()
	Audio.play_sfx(Audio.normal_btn_sfx)
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")


func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	queue_free()

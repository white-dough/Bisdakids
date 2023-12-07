extends CanvasLayer

func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	hide()

func _on_no_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	hide()

func _on_yes_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)

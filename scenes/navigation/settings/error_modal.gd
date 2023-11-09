extends CanvasLayer

func _on_ok_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	visible = false

extends CanvasLayer

func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	visible = false

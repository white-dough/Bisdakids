extends Node

func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	queue_free()

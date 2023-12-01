extends Node2D


func _ready():
	Audio.play_sfx(Audio.success_sfx)
	
func _on_play_pressed():
	$ButtonClickSfx.play()

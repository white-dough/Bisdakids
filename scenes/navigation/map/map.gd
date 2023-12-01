extends Node

func _ready():
	if Audio.bgm_node.get_stream() != Audio.main_bgm:
		Audio.play_bgm(Audio.main_bgm)


extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if Audio.bgm_node.get_stream() != Audio.main_bgm:
		Audio.play_bgm(Audio.main_bgm)
	if not Game.premium:
		#BannerAds.destroy_banner()
		#BannerAds.ad_view.show()
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

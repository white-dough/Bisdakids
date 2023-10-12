extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	BannerAds.ad_view.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_1_button_pressed():
	print("hello")

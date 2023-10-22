extends Sprite2D

#func _ready():
#@onready var animate_cloud1 = $anim_cloud1

func _process(_delta):
	$anim_hotairballoon.play("hotair_balloon")
	#animate_cloud1.play("cloud1")

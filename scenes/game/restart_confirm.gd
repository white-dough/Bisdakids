extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	hide()

func _on_no_btn_pressed():
	Audio.play_sfx(Audio.normal_btn_sfx)
	hide()

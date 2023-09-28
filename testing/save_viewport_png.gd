extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	await RenderingServer.frame_post_draw
	$".".get_texture().get_image().save_png("res://Screenshot5.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

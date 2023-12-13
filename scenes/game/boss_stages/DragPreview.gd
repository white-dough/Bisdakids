extends Sprite2D

func _process(_delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_released("click_primary"):
		queue_free()

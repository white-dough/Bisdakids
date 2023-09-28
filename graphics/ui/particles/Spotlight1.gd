extends Sprite2D

var time := 0.0
var scale_factor := 1.0  # adjust the scaling intensity
var scale_speed := 0.5   # adjust the scaling speed

func _process(delta):
	time += delta * scale_speed
	var scale_value = sin(time) * scale_factor
	scale = Vector2(scale_value, scale_value)

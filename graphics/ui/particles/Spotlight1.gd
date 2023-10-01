extends Sprite2D

var time := 0.0
var scale_factor := 1.5  
var hasPoppedUp := false  

func _ready():
	time = 0.0

func _process(delta):
	if !hasPoppedUp: 
		time += delta  
		var scale_value = sin(time) * scale_factor
		scale = Vector2(scale_value, scale_value)

		if scale_value >= 1.0:
			hasPoppedUp = true
			scale = Vector2(1.0, 1.0) 

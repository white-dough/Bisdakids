extends Sprite2D

var time := 0.0
var amplitude := 20.0  # floating height
var period := 2.5      # Adjust the time it takes for one full float
var initial_x := 710   # Initial X-axis position

func _ready():
	time = 0.0
	set_process(true)  # Ensure the _process function is active
	position.x = initial_x  # Set the initial X-axis position

func _process(delta):
	time += delta

	var y_offset = sin(time / period) * amplitude
	position.y = 300 + y_offset  

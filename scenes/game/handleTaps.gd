extends Node2D

@onready var timer: Timer = $Timer
@onready var time_lbl: Label = $VBoxContainer/TimeLbl


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_lbl.text = "%d:%02d" % [floor(timer.time_left / 60), int(timer.time_left) % 60]
	

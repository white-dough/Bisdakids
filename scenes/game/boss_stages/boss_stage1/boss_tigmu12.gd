extends CanvasLayer

var correct_answer: String = "Korona"
@onready var choice_lbls: Array = [$ChoicesVbox/ChoiceLbl1,
							$ChoicesVbox/ChoiceLbl2,
							$ChoicesVbox/ChoiceLbl3,
							$ChoicesVbox/ChoiceLbl4]
@onready var level_node : Node2D = $"../.."

func _ready():
	for label in choice_lbls:
		label.gui_input.connect(answer_attempt.bind(label.get_text()))


func answer_attempt(event: InputEvent, answer: String) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if answer == correct_answer:
			level_node.wave_finished()
		else:
			var hud_timer : Timer = $"../../HUD/ColorRect/Panel/ContainerHUD/TimerBar/Timer"
			if hud_timer.get_time_left() - 60 < 0:
				hud_timer.start(0.05)
				return
			hud_timer.start(hud_timer.get_time_left() - 60)
			

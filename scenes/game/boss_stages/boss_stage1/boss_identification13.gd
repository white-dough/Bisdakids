extends CanvasLayer

@onready var answer_input: LineEdit = $LabelsVbox/AnswerInput
var correct_answer: String = "EDAD"
@onready var level_node : Node2D = $"../.."

func _ready():
	answer_input.text_submitted.connect(answer_attempt)

func answer_attempt(answer: String) -> void:
	answer = answer.to_upper()
	if answer == correct_answer:
		level_node.wave_finished()
	else:
		var hud_timer : Timer = $"../../HUD/ColorRect/Panel/ContainerHUD/TimerBar/Timer"
		if hud_timer.get_time_left() - 60 < 0:
			hud_timer.start(0.05)
			return
		hud_timer.start(hud_timer.get_time_left() - 60)
	answer_input.clear()

extends CanvasLayer

@onready var answer_input: LineEdit = $AnswerInput
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
		var red_lbl : StyleBox = load("res://themes/tigmo_red_lbl_stylebox.tres")
		answer_input.add_theme_stylebox_override("normal", red_lbl)
		
		var original_x : float = answer_input.get_position().x
		var original_y : float = answer_input.get_position().y
		
		var wrong_answer_tween: Tween = create_tween()
		wrong_answer_tween.tween_property(answer_input, "position", Vector2(original_x - 3, original_y + 5), 0.1)
		wrong_answer_tween.tween_property(answer_input, "position", Vector2(original_x + 2, original_y + 7), 0.2)
		wrong_answer_tween.tween_property(answer_input, "position", Vector2(original_x - 5, original_y - 4), 0.2)
		wrong_answer_tween.tween_property(answer_input, "position", Vector2(original_x + 1, original_y + 6), 0.2)
		wrong_answer_tween.tween_property(answer_input, "position", Vector2(original_x + 4, original_y - 3), 0.2)
		wrong_answer_tween.tween_property(answer_input, "position", Vector2(original_x - 7, original_y + 2), 0.1)
		await wrong_answer_tween.finished
		answer_input.remove_theme_stylebox_override("normal")
		answer_input.set_position(Vector2(original_x,original_y))
	answer_input.clear()

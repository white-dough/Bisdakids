extends CanvasLayer

var correct_answer: String = "Korona"
@onready var choice_lbls: Array = [$Choices/ChoiceLbl1,
							$Choices/ChoiceLbl2,
							$Choices/ChoiceLbl3,
							$Choices/ChoiceLbl4]
@onready var level_node : Node2D = $"../.."

func _ready():
	for label in choice_lbls:
		label.gui_input.connect(answer_attempt.bind(label))


func answer_attempt(event: InputEvent, answer_lbl: Label) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var answer : String = answer_lbl.get_text()
		if answer == correct_answer:
			Audio.play_sfx(Audio.correct_sfx)
			level_node.wave_finished()
		else:
			Audio.play_sfx(Audio.incorrect_sfx)
			var hud_timer : Timer = $"../../HUD/ColorRect/Panel/ContainerHUD/TimerBar/Timer"
			if hud_timer.get_time_left() - 60 < 0:
				hud_timer.start(0.05)
				return
			hud_timer.start(hud_timer.get_time_left() - 60)
			
			#for the timer
			var time_minus_effect : Sprite2D = $"../../HUD/ColorRect/Panel/ContainerHUD/TimerBar/TimeMinus"
			var timer_node : Timer = Timer.new()
			timer_node.wait_time = 1.5
			add_child(timer_node)
			time_minus_effect.visible = true
			timer_node.start()
			timer_node.timeout.connect(remove_red)
			
			
			var red_lbl : StyleBox = load("res://themes/tigmo_red_lbl_stylebox.tres")
			answer_lbl.add_theme_stylebox_override("normal", red_lbl)
			
			var original_x : float = answer_lbl.get_position().x
			var original_y : float = answer_lbl.get_position().y
			
			var wrong_answer_tween: Tween = create_tween()
			wrong_answer_tween.tween_property(answer_lbl, "position", Vector2(original_x - 3, original_y + 5), 0.1)
			wrong_answer_tween.tween_property(answer_lbl, "position", Vector2(original_x + 2, original_y + 7), 0.2)
			wrong_answer_tween.tween_property(answer_lbl, "position", Vector2(original_x - 5, original_y - 4), 0.2)
			wrong_answer_tween.tween_property(answer_lbl, "position", Vector2(original_x + 1, original_y + 6), 0.2)
			wrong_answer_tween.tween_property(answer_lbl, "position", Vector2(original_x + 4, original_y - 3), 0.2)
			wrong_answer_tween.tween_property(answer_lbl, "position", Vector2(original_x - 7, original_y + 2), 0.1)
			await wrong_answer_tween.finished
			answer_lbl.set_position(Vector2(original_x,original_y))
func remove_red():
	var time_minus_effect : Sprite2D = $"../../HUD/ColorRect/Panel/ContainerHUD/TimerBar/TimeMinus"
	time_minus_effect.visible = false

extends TextureRect

var default_texture : Texture2D = texture
@onready var level_node : Node2D = $"/root/Level"

func _can_drop_data(at_position, data):
	if data["group_node"].get_name() == get_name():
		return true
	return false

func _drop_data(at_position, data):
	
	texture = data["texture"]
	validate_answer(data)

func validate_answer(data : Dictionary):
	
	if data["name"] != "CorrectAnswer":
		texture = default_texture
		#reddd
		Audio.play_sfx(Audio.incorrect_sfx)
		var hud_timer : Timer = $"../../../../HUD/ColorRect/Panel/ContainerHUD/TimerBar/Timer"
		if hud_timer.get_time_left() - 60 < 0:
			hud_timer.start(0.05)
			return
		hud_timer.start(hud_timer.get_time_left() - 60)
		
		#for the timer
		var time_minus_effect : Sprite2D = $"../../../../HUD/ColorRect/Panel/ContainerHUD/TimerBar/TimeMinus"
		var timer_node : Timer = Timer.new()
		timer_node.wait_time = 1.5
		add_child(timer_node)
		time_minus_effect.visible = true
		timer_node.start()
		timer_node.timeout.connect(remove_red)		
		
		var original_x : float = data["node"].get_position().x
		var original_y : float = data["node"].get_position().y
		
		var wrong_answer_tween: Tween = create_tween()
		wrong_answer_tween.tween_property(data["node"], "position", Vector2(original_x - 3, original_y + 5), 0.1)
		wrong_answer_tween.tween_property(data["node"], "position", Vector2(original_x + 2, original_y + 7), 0.2)
		wrong_answer_tween.tween_property(data["node"], "position", Vector2(original_x - 5, original_y - 4), 0.2)
		wrong_answer_tween.tween_property(data["node"], "position", Vector2(original_x + 1, original_y + 6), 0.2)
		wrong_answer_tween.tween_property(data["node"], "position", Vector2(original_x + 4, original_y - 3), 0.2)
		wrong_answer_tween.tween_property(data["node"], "position", Vector2(original_x - 7, original_y + 2), 0.1)
		await wrong_answer_tween.finished
		data["node"].set_position(Vector2(original_x,original_y))
		return

	Audio.play_sfx(Audio.correct_sfx)
	
	
	#finish
	if get_name() == "AnswerFld5":
		level_node.wave_finished()
	else:
		data["group_node"].queue_free()
		data["next_group"].show()
		
func remove_red():
	var time_minus_effect : Sprite2D = $"../../../../HUD/ColorRect/Panel/ContainerHUD/TimerBar/TimeMinus"
	time_minus_effect.visible = false

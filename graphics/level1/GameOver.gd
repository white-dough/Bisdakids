extends CanvasLayer

func _ready():
	var level_num : String = str($"..".level_num)
	$Gameover_2x/Level_label.set_text(level_num)

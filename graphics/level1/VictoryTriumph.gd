extends CanvasLayer

func _ready():
	var level_num : String = str($"..".level_num)
	$Node/VictoryTriumph1_2x/Level_label.set_text(level_num)

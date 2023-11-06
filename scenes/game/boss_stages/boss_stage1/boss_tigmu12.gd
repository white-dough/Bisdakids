extends CanvasLayer

var correct_answer: String = "Korona"
@onready var choice_lbls: Array = [$ChoicesVbox/ChoiceLbl1,
							$ChoicesVbox/ChoiceLbl2,
							$ChoicesVbox/ChoiceLbl3,
							$ChoicesVbox/ChoiceLbl4]

func _ready():
	for label in choice_lbls:
		label.gui_input.connect(answer_attempt.bind(label.get_text()))


func answer_attempt(event: InputEvent, answer: String) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if answer == correct_answer:
			pass
		else:
			pass
			

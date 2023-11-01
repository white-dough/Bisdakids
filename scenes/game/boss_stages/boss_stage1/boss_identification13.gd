extends CanvasLayer

@onready var answer_input: LineEdit = $LabelsVbox/AnswerInput
var correct_answer: String = "EDAD"

func _ready():
	answer_input.text_submitted.connect(answer_attempt)

func answer_attempt(answer: String) -> void:
	answer = answer.to_upper()
	if answer == correct_answer:
		print(answer)
	else:
		print("wrong")
	answer_input.clear()

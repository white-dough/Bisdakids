extends Control

@onready var closeBtn: TextureButton = $"../Modal/Background/ModalPnl/CloseBtn"
@onready var modal: CanvasLayer = $"../Modal"
@onready var modalLabel: Label = $"../Modal/Background/ModalPnl/ContentVbox/Lbl"
@onready var descLbl: Label = $"../Modal/Background/ModalPnl/ContentVbox/DescLbl"
@onready var levelComplete: PackedScene = load("res://graphics/level1/LevelCompleted.tscn")

@onready var error_modal : CanvasLayer = $ErrorModal

@onready var duwaBtn: TextureButton = $"../Modal/Background/ModalPnl/ContentVbox/OkBtn"
var level_btns: Array
#@onready var settings_scene: CanvasLayer = $"res://scenes/navigation/settings/settings.tscn"

func _ready():
	for button in get_children():
		level_btns.append(button)
		var level_key: String = button.get_name()
		button.pressed.connect(modal_display.bind(button, level_key))
	load_level_btns()
#	closeBtn.pressed.connect(closeModal.bind("res://scenes/navigation/map/map.tscn"))

func load_level_btns() -> void:
	var completed_levels : Dictionary
	for level in Game.progress:
		completed_levels[level] = Game.progress[level]
		if Game.progress[level] <= 0:
			break
	for i in completed_levels.size():
		level_btns[i].disabled = false
		if i == 0:
			continue
		level_btns[i].get_child(0).value = Game.progress[level_btns[i].get_name()]
		level_btns[i].get_child(0).visible = true



func modal_display(button: TextureButton, level_key: String) -> void:
	var highscore: int = Game.progress[level_key]
	modal.show()
	modalLabel.text = level_key.capitalize()
	if(highscore == 5000):
		#get_tree().change_scene_to_file(levelComplete)
		modal_btn_pressed(levelComplete)
		#descLbl.text = "Nalampos na nimo!"
	elif(highscore == 0):
		descLbl.text = "Wala pakay kaagi, duwa para malampos nimo."
	else:
		descLbl.text = "Duwa pa para malampos!"
	duwaBtn.pressed.connect(changeScene.bind("res://scenes/game/"+level_key+"/"+level_key+".tscn"))


func _on_settings_button_pressed():
	print('settings')


func closeModal(link):
	modal.hide()
	get_tree().change_scene_to_file(link)

func changeScene(link):
	get_tree().change_scene_to_file(link)

func modal_btn_pressed(modal_scene):
	for child in get_children():
		if child != error_modal:
			child.queue_free()
	add_child(modal_scene.instantiate())



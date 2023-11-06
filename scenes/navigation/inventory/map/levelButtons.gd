extends Control

@onready var closeBtn: TextureButton = $"/root/Node2D/Control/Modal/Background/ModalPnl/CloseBtn"
@onready var modal: CanvasLayer = $"/root/Node2D/Control/Modal"
@onready var modalPnl = $"/root/Node2D/Control/Modal/Background/ModalPnl"
@onready var modalLabel: Label = $"/root/Node2D/Control/Modal/Background/ModalPnl/ContentVbox/Lbl"
@onready var descLbl: Label = $"/root/Node2D/Control/Modal/Background/ModalPnl/ContentVbox/DescLbl"
@onready var levelComplete: PackedScene = load("res://graphics/level1/LevelCompleted.tscn")

@onready var error_modal : CanvasLayer = $ErrorModal

@onready var level1Progress: TextureProgressBar = $"/root/Node2D/Control/Level1Button/Level1Progress"
@onready var level2Progress: TextureProgressBar = $"/root/Node2D/Control/Level2Button/Level2Progress"
@onready var level3Progress: TextureProgressBar = $"/root/Node2D/Control/Level3Button/Level3Progress"
@onready var level4Progress: TextureProgressBar = $"/root/Node2D/Control/Level4Button/Level4Progress"
@onready var level5Progress: TextureProgressBar = $"/root/Node2D/Control/Level5Button/Level5Progress"

@onready var duwaBtn: TextureButton = $"/root/Node2D/Control/Modal/Background/ModalPnl/ContentVbox/OkBtn"
var level_btns: Array
#@onready var settings_scene: CanvasLayer = $"res://scenes/navigation/settings/settings.tscn"

func _ready():
	for button in get_children():
		var level_key: String =  button.get_name().to_lower()
		button.get_child(0).set_value(Game.progress[level_key])
		button.pressed.connect(level_pressed.bind(button, level_key))
		

func level_pressed(button_pressesd: TextureButton, level_key: String) -> void:
	var highscore: int = Game.progress[level_key]
	modalDisplay(highscore, level_key)

func _on_settings_button_pressed():
	print('settings')

func modalDisplay(highscore: int, level_key: String):
#	modalLabel.text = labelText
#	modal.show()
#	if(levelProgress == 100):
#		#get_tree().change_scene_to_file(levelComplete)
#		modal_btn_pressed(levelComplete)
#		#descLbl.text = "Nalampos na nimo!"
#	elif(levelProgress == 0):
#		descLbl.text = "Wala pakay kaagi, duwa para malampos nimo."
#	else:
#		descLbl.text = "Duwa pa para malampos!"
	match(level_key):
		"Level 1":
			duwaBtn.pressed.connect(changeScene.bind("res://scenes/game/level1/level_1.tscn"))
		"Level 2":
			duwaBtn.pressed.connect(changeScene.bind("res://scenes/game/level2/level_2.tscn"))
		"Level 3":
			duwaBtn.pressed.connect(changeScene.bind("res://scenes/game/level3/level_3.tscn"))
		"Level 4":
			duwaBtn.pressed.connect(changeScene.bind("res://scenes/game/level4/level_4.tscn"))
		"Level 5":
			duwaBtn.pressed.connect(changeScene.bind("res://scenes/game/level5/level_5.tscn"))

func _on_close_btn_pressed():
	modal.hide()
	#modalPnl.visible = false

func changeScene(link):
	get_tree().change_scene_to_file(link)

func modal_btn_pressed(modal_scene):
	for child in get_children():
		if child != error_modal:
			child.queue_free()
	add_child(modal_scene.instantiate())

extends Control

@onready var modal_close_btn: TextureButton = $"../LevelModal/ModalPanel/CloseBtn"
@onready var modal_title_lbl: Label = $"../LevelModal/ModalPanel/TitleContainer/TitleLbl"
@onready var modal_scoretxt_lbl: Label = $"../LevelModal/ModalPanel/ContentContainer/HBoxContainer/HighscoreTxtLbl"
@onready var modal_score_lbl: Label = $"../LevelModal/ModalPanel/ContentContainer/HBoxContainer/HighscoreLbl"
@onready var modal_play_btn: TextureButton = $"../LevelModal/ModalPanel/BtnContainer/PlayBtn"
@onready var modal_star_bar: TextureProgressBar = $"../LevelModal/ModalPanel/StarBar"
@onready var modal: CanvasLayer = $"../LevelModal"

#@onready var error_modal : CanvasLayer = $ErrorModal
var level_btns: Array
#@onready var settings_scene: CanvasLayer = $"res://scenes/navigation/settings/settings.tscn"

func _ready():
	for button in get_children():
		level_btns.append(button)
		var level_key: String = button.get_name()
		button.pressed.connect(modal_display.bind(level_key))
	load_level_btns()
	modal_close_btn.pressed.connect(closeModal)
	

func load_level_btns() -> void:
	var completed_levels : Dictionary = {}
	for level in Game.progress:
		completed_levels[level] = Game.progress[level]
		if Game.progress[level] <= 0:
			break
	#loop that will not show the star progress of the last iteration
	for i in completed_levels.size():
		level_btns[i].disabled = false
		if i == 4:
			if Game.progress[level_btns[i].get_name()] > 0:
				level_btns[i].get_child(0).value = Game.progress[level_btns[i].get_name()]
				level_btns[i].get_child(0).visible = true
		if i == completed_levels.size() - 1:
			continue
		level_btns[i].get_child(0).value = Game.progress[level_btns[i].get_name()]
		level_btns[i].get_child(0).visible = true

func modal_display(level_key: String) -> void:
	Audio.play_sfx(Audio.level_btn_sfx)
	var level_titles : Dictionary = {
		"level1": "Lebel 1: Kalasangan sa Kahayag",
		"level2": "Lebel 2: Kabukiran",
		"level3": "Lebel 3: Siyudad Merkado",
		"level4": "Lebel 4: Hardin sa Bulak",
		"level5": "Lebel 5: Kastilyo sa Kangitngit"
	}
	var highscore: int = Game.progress[level_key]
	#progress star, level title, score, if not latest, play
	var level_title:  String = level_titles[level_key]
	modal_title_lbl.set_text(level_title)
	modal_score_lbl.set_text(str(highscore))
	modal_star_bar.set_value(int(highscore))
	modal_score_lbl.visible = true
	modal_scoretxt_lbl.visible = true
	if(highscore == 0):
		modal_score_lbl.visible = false
		modal_scoretxt_lbl.visible = false
	if modal_play_btn.is_connected("pressed", changeScene):
		modal_play_btn.pressed.disconnect(changeScene)
	modal_play_btn.pressed.connect(changeScene.bind("res://scenes/game/"+level_key+"/"+level_key+".tscn"))
	modal.show()

func closeModal():
	Audio.play_sfx(Audio.close_btn_sfx)
	modal.hide()

func changeScene(link):
	Audio.play_sfx(Audio.normal_btn_sfx)
	get_tree().change_scene_to_file(link)




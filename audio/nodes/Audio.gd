extends Node

@onready var bgm_node: AudioStreamPlayer = $MainMenuBGM
@onready var sfx_node: AudioStreamPlayer = $SFX

#background musics
@onready var main_bgm: AudioStream = preload("res://audio/assets/bgm/main_bgm.mp3")
@onready var levels_bgm: AudioStream = preload("res://audio/assets/bgm/levels_bgm.wav")
@onready var boss_bgm: AudioStream = preload("res://audio/assets/bgm/boss_battle_bgm.wav")

#clicks
@onready var wood_btn_sfx: AudioStream = preload("res://audio/assets/sfx/wood_click_sfx.mp3")
@onready var close_btn_sfx: AudioStream = preload("res://audio/assets/sfx/close_button_sfx.mp3")
@onready var normal_btn_sfx: AudioStream = preload("res://audio/assets/sfx/button_clicked_sfx.mp3")
@onready var level_btn_sfx: AudioStream = preload("res://audio/assets/sfx/levels_btn_sfx.mp3")

#effects
@onready var hint_sfx: AudioStream = preload("res://audio/assets/sfx/hint_sfx.mp3")
@onready var incorrect_sfx: AudioStream = preload("res://audio/assets/sfx/incorrect_sfx.mp3")
@onready var freeze_sfx: AudioStream = preload("res://audio/assets/sfx/freeze_sfx.wav")
@onready var correct_sfx: AudioStream = preload("res://audio/assets/sfx/object_found_sfx.mp3")
@onready var book_flip_sfx: AudioStream = preload("res://audio/assets/sfx/word_def_sfx.mp3")

#result sfx
@onready var success_sfx: AudioStream = preload("res://audio/assets/sfx/victory_sfx.wav")
@onready var fail_sfx: AudioStream = preload("res://audio/assets/sfx/failed_sfx.wav")
@onready var dt_claim_sfx: AudioStream = preload("res://audio/assets/sfx/claim_reward_dt_sfx.wav")


func play_sfx(sfx: AudioStream) -> void:
	sfx_node.stop()
	sfx_node.set_stream(sfx)
	sfx_node.play()

func play_bgm(scene_bgm: AudioStream) -> void:
	bgm_node.stop()
	bgm_node.set_stream(scene_bgm)
	bgm_node.play()

#signal if not main menu or level select stop playing

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




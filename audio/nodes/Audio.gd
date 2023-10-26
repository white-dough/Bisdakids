extends Node

@onready var bgm_node: AudioStreamPlayer = $MainMenuBGM
@onready var btn_sfx_node: AudioStreamPlayer = $ButtonClickedSFX

@onready var main_bgm: AudioStream = preload("res://audio/assets/bgm/main_bgm.wav")
@onready var levels_bgm: AudioStream = preload("res://audio/assets/bgm/levels_bgm.wav")
@onready var boss_bgm: AudioStream = preload("res://audio/assets/bgm/boss_battle_bgm.mp3")

@onready var wood_btn_sfx: AudioStream = preload("res://audio/assets/sfx/wood_click_sfx.wav")
@onready var close_btn_sfx: AudioStream = preload("res://audio/assets/sfx/close_button_sfx.wav")
@onready var normal_btn_sfx: AudioStream = preload("res://audio/assets/sfx/button_clicked_sfx.mp3")


func button_click(btn_sfx: AudioStream) -> void:
	btn_sfx_node.stop()
	btn_sfx_node.set_stream(btn_sfx)
	btn_sfx_node.play()

func play_bgm(scene_bgm: AudioStream) -> void:
	bgm_node.stop()
	bgm_node.set_stream(scene_bgm)
	bgm_node.play()

#signal if not main menu or level select stop playing
#s

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


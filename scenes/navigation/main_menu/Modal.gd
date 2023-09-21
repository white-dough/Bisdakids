extends Control

#@onready var mainmenu_modal_node : Control = self
@onready var settings_scene : PackedScene = load("res://scenes/navigation/settings/settings.tscn")
@onready var settings_btn = $"../Control/SettingsBtn"
#@onready var settings_scene_path = load("res://scenes/navigation/settings/settings.tscn")
#@onready var settings_btn = $"../Control/SettingsBtn"

func _ready():
	settings_btn.pressed.connect(modal_btn_pressed.bind(settings_scene))
#	settings_btn.pressed.connect(modal_btn_pressed.bind(settings_btn))
# Called every frame. 'delta' is the elapsed time since the previous frame.


func modal_btn_pressed(modal_scene):
	if get_child_count() > 0: get_child(0).queue_free()
	add_child(modal_scene.instantiate())

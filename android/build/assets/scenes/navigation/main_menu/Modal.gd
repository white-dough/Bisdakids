extends Control

#@onready var mainmenu_modal_node : Control = self
@onready var settings_scene : PackedScene = load("res://scenes/navigation/settings/settings.tscn")
@onready var error_scene : PackedScene = load("res://scenes/navigation/settings/error_modal.tscn")
@onready var settings_btn : TextureButton = $"../Control/HBoxContainer2/Settings"
@onready var store_btn : TextureButton = $"../Control/HBoxContainer2/Shop"
@onready var store_scene : PackedScene = load("res://scenes/navigation/store_inventory/store/store.tscn")
@onready var error_modal : CanvasLayer = $ErrorModal

#@onready var settings_scene_path = load("res://scenes/navigation/settings/settings.tscn")
#@onready var settings_btn = $"../Control/SettingsBtn"
func _ready():
	settings_btn.pressed.connect(modal_btn_pressed.bind(settings_scene))
	store_btn.pressed.connect(modal_btn_pressed.bind(store_scene))
	
#	settings_btn.pressed.connect(modal_btn_pressed.bind(settings_btn))
# Called every frame. 'delta' is the elapsed time since the previous frame.


func modal_btn_pressed(modal_scene):
	for child in get_children():
		if child != error_modal:
			child.queue_free()
	add_child(modal_scene.instantiate())

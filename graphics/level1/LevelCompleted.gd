extends CanvasLayer

@onready var level_node : Node2D = $"../"
@onready var level_name: String = level_node.level_name
var next_level : String

func _ready():
	next_level = incrementLevel(level_name)
	
func _on_map_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/navigation/map/map.tscn")

func incrementLevel(levelString):
	var prefix = levelString.left(levelString.length() - 1) # Extracts the prefix ("level")
	var levelNumber = levelString.substr(levelString.length() - 1, 1).to_int() # Extracts the number part and converts it to an integer
	var incrementedLevel = prefix + str(levelNumber + 1) # Increments the number part and constructs the new string
	return incrementedLevel

func _on_playagain_btn_pressed():
	get_tree().reload_current_scene()

func _on_next_btn_pressed():
	if level_name == "level5":
		changeScene("res://scenes/navigation/map/map.tscn", 0)
		return
	if level_name == "level4":
		changeScene("res://scenes/game/boss_stages/boss_stage1/boss1.tscn", 40)
		return
	changeScene("res://scenes/game/" + next_level + "/" + next_level + ".tscn", 30)
	
	
func changeScene(link : String, energy_cost : int) -> void:
	if Game.energy_system["energy"] < energy_cost:
		$"../no_energy".show()
	else:
		Game.deduct_energy(energy_cost)
		Audio.play_sfx(Audio.normal_btn_sfx)
		get_tree().change_scene_to_file(link)

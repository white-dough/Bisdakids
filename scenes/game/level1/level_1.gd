extends Node2D

@onready var level_name : String = "level1"
@onready var count_of_objects_to_find: int = 10
@onready var level_time: float =  600 #15 minutes
@onready var current_objects: Array = $GameScene.current_objects

@onready var star1 : float = level_time / 3
@onready var star2 : float = level_time - star1
@onready var star3 : float = level_time * 0.85

@onready var success_prompt : CanvasLayer = $VictoryTriumph

@onready var failed_prompt : CanvasLayer = $GameOver
@onready var level_failed : CanvasLayer = $LevelFailed

@onready var level_success : CanvasLayer = $LevelCompleted
@onready var star_bar : TextureProgressBar = level_success.find_child('StarBar')
@onready var highscore_label : Label = level_success.find_child('HighscoreLbl')
@onready var score_label : Label = level_success.find_child('ScoreLbl')


func _ready():
	$HUD.connect("level_finished", level_completed)
	
func _process(delta):
	pass
#	if isArrayEmpty(current_objects):
#		print("The array is empty")
#	else:
#		print("The array is not empty")
#for object in current_objects:
#		if not object is Area2D:
#			print(object)

func level_completed(time_left):
	if time_left > 0:
		var prompt_timer : Timer = Timer.new()
		prompt_timer.wait_time = 3
		add_child(prompt_timer)
		success_prompt.visible = true
		prompt_timer.start()
		await prompt_timer.timeout
		if Game.progress[level_name] < time_left:
			highscore_label.set_text(str(int(time_left)))#new highscore
			Game.progress[level_name] = int(time_left)
		else:
			highscore_label.set_text(str(Game.progress[level_name]))
		score_label.set_text(str(int(time_left)))
		star_bar.set_max(level_time)
		star_bar.set_value(time_left)
		level_success.visible = true
		Game.update_local_save()
		
	
	


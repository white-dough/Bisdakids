extends Node2D

@export var level_name : String
@export var level_time: float
@export var level_num: int

@onready var count_of_objects_to_find: int = 10
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
	Audio.play_bgm(Audio.levels_bgm)
	$HUD.connect("level_finished", level_completed)
	success_prompt.visibility_changed.connect(load_interstitial_ad)
	failed_prompt.visibility_changed.connect(load_interstitial_ad)
	BannerAds.ad_view.hide()
	
func load_interstitial_ad():
	if not Game.premium:
		InterstitialAds.load_show_interstitial()

func level_completed(time_left):
	if time_left > 0:
		#print("success")
		Audio.play_bgm(Audio.success_sfx)
		var prompt_timer : Timer = Timer.new()
		prompt_timer.wait_time = 3
		add_child(prompt_timer)
		success_prompt.visible = true
		prompt_timer.start()
		await prompt_timer.timeout
		var score: int = 5000 * (time_left / level_time)
		if Game.progress[level_name] < score:
			highscore_label.set_text(str(int(score)))#new highscore
			Game.progress[level_name] = int(score)
			Game.progress["timestamp"] = Time.get_unix_time_from_system()
			Game.update_local_save()
		else:
			highscore_label.set_text(str(Game.progress[level_name]))
		score_label.set_text(str(int(score)))
		star_bar.set_value(score)
		level_success.visible = true
		#for daily task progression
		Game.daily_task_progression("Score",float(int(score)))
		Game.daily_task_progression("Level Finish",1)
		Game.daily_task_progression("Detective",10)
		
	else:
		#print("fail")
		Audio.play_bgm(Audio.fail_sfx)
		var prompt_timer : Timer = Timer.new()
		prompt_timer.wait_time = 3
		add_child(prompt_timer)
		failed_prompt.visible = true
		prompt_timer.start()
		await prompt_timer.timeout
		level_failed.visible = true




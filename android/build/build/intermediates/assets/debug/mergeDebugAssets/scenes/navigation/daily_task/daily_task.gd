extends CanvasLayer
@onready var TaskTitle : Label = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel/TaskDetailVbox/TaskTitleLbl
@onready var TaskTitle2 : Label = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel2/TaskDetailVbox/TaskTitleLbl
@onready var TaskTitle3 : Label = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel3/TaskDetailVbox/TaskTitleLbl

@onready var TaskDesc : Label = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel/TaskDetailVbox/TaskDescLbl
@onready var TaskDesc2 : Label = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel2/TaskDetailVbox/TaskDescLbl
@onready var TaskDesc3 : Label = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel3/TaskDetailVbox/TaskDescLbl

@onready var TaskBar : ProgressBar = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel/TaskDetailVbox/ProgressBar
@onready var TaskBarLbl : Label = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel/TaskDetailVbox/ProgressBar/ProgressLbl
@onready var TaskImg : TextureRect = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel/RewardPnlcont/RewardImg
@onready var test = preload("res://graphics/ui/icons/2x/victoryTriumph_1@2x.png")
@onready var titles : Array = [TaskTitle, TaskTitle2, TaskTitle3]
@onready var tasktitles : Array = []
@onready var descs : Array = [TaskDesc, TaskDesc2, TaskDesc3]
@onready var taskdescs : Array = []

func _ready():
	Game.daily_task_logic()
	#titles
	for x in Game.daily_task:
		tasktitles.append(x)
	for i in titles.size():
		titles[i].set_text(tasktitles[i])
	#desc
	for x in Game.daily_task:
		taskdescs.append(Game.daily_task[x])
	for i in descs.size():
		descs[i].set_text(taskdescs[i])
	TaskImg.set_texture(test)
	#verification if task is done
	#reward
	#change bar to buttond disabled = empty
	#img changechange in dt json

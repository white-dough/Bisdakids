extends CanvasLayer

@onready var task_node1 = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel/TaskDetailVbox
@onready var task_node2 = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel2/TaskDetailVbox
@onready var task_node3 = $DailyTaskPnl/DailyTaskVbox/TaskListVbox/TaskPanel3/TaskDetailVbox

@onready var TaskTitleLbl1 : Label = task_node1.get_node("TaskTitleLbl")
@onready var TaskTitleLbl2 : Label = task_node2.get_node("TaskTitleLbl")
@onready var TaskTitleLbl3 : Label = task_node3.get_node("TaskTitleLbl")
@onready var title_labels : Array = [TaskTitleLbl1, TaskTitleLbl2, TaskTitleLbl3]

@onready var TaskDescLbl1 : Label = task_node1.get_node("TaskDescLbl")
@onready var TaskDescLbl2 : Label = task_node2.get_node("TaskDescLbl")
@onready var TaskDescLbl3 : Label = task_node3.get_node("TaskDescLbl")
@onready var desc_labels : Array = [TaskDescLbl1, TaskDescLbl2, TaskDescLbl3]

@onready var TaskBar1 : ProgressBar = task_node1.get_node("ProgressBar")
@onready var TaskBar2 : ProgressBar = task_node2.get_node("ProgressBar")
@onready var TaskBar3 : ProgressBar = task_node3.get_node("ProgressBar")
@onready var task_bars : Array = [TaskBar1, TaskBar2, TaskBar3]

@onready var TaskBarLbl1 : Label = task_node1.get_node("ProgressBar/ProgressLbl")
@onready var TaskBarLbl2 : Label = task_node2.get_node("ProgressBar/ProgressLbl")
@onready var TaskBarLbl3 : Label = task_node3.get_node("ProgressBar/ProgressLbl")
@onready var task_bar_labels : Array = [TaskBarLbl1, TaskBarLbl2, TaskBarLbl3]

@onready var TaskImg1 : TextureRect = task_node1.get_node("../RewardPnlcont/RewardImg")
@onready var TaskImg2 : TextureRect = task_node2.get_node("../RewardPnlcont/RewardImg")
@onready var TaskImg3: TextureRect = task_node3.get_node("../RewardPnlcont/RewardImg")
@onready var task_imgs: Array = [TaskImg1, TaskImg2, TaskImg3]

@onready var RewardQuantityLbl1: Label = task_node1.get_node("../RewardPnlcont/RewardQuantityLbl")
@onready var RewardQuantityLbl2: Label = task_node2.get_node("../RewardPnlcont/RewardQuantityLbl")
@onready var RewardQuantityLbl3: Label = task_node3.get_node("../RewardPnlcont/RewardQuantityLbl")
@onready var reward_quantity_labels: Array = [RewardQuantityLbl1, RewardQuantityLbl2, RewardQuantityLbl3]

@onready var RewardLbl1: Label = task_node1.get_node("../RewardPnlcont/RewardLbl")
@onready var RewardLbl2: Label = task_node2.get_node("../RewardPnlcont/RewardLbl")
@onready var RewardLbl3: Label = task_node3.get_node("../RewardPnlcont/RewardLbl")
@onready var reward_labels: Array = [RewardLbl1, RewardLbl2, RewardLbl3]

@onready var RewardBtn1: TextureButton = task_node1.get_node("../RewardPnlcont/RewardBtn")
@onready var RewardBtn2: TextureButton = task_node2.get_node("../RewardPnlcont/RewardBtn")
@onready var RewardBtn3: TextureButton = task_node3.get_node("../RewardPnlcont/RewardBtn")
@onready var reward_buttons: Array = [RewardBtn1, RewardBtn2, RewardBtn3]

@onready var ClaimFlag1: CheckButton = task_node1.get_node("ClaimFlag")
@onready var ClaimFlag2: CheckButton = task_node2.get_node("ClaimFlag")
@onready var ClaimFlag3: CheckButton = task_node3.get_node("ClaimFlag")
@onready var claim_flags: Array = [ClaimFlag1, ClaimFlag2, ClaimFlag3]

@onready var test = load("res://graphics/ui/icons/2x/victoryTriumph_1@2x.png")

var task_title : Array = []
var taskdescs : Array = []

func _ready():
	
#	for panel in reward_panels:
#		panel.connect("gui_input", claim_attempt.bind(panel))
	Game.daily_task_logic()
	#first loop deals with the task titles (including unix timestamp). 
#	the second deals with the TAsk title labels
	for x in Game.daily_task:
		if x == "unix_datestamp":
			break
		task_title.append(x)
	set_labels()
	for button in reward_buttons:
#		print(button.get_name())
		button.connect("pressed", claim_attempt.bind(int(str(button.name))))
		
	

	
func set_labels():
	for i in task_title.size():
		var task_iterate = Game.daily_task[task_title[i]]
		title_labels[i].set_text(str(task_title[i]))
		desc_labels[i].set_text(str(task_iterate["task_desc"]))
		reward_quantity_labels[i].set_text(str("x" ,task_iterate["reward_quantity"]))
		reward_labels[i].set_text(str(task_iterate["reward"]))
		task_imgs[i].set_texture(Game.texture_logic(task_iterate["reward"]))
		task_bars[i].set_max(float(task_iterate["goal"]))
		print(task_iterate)
		task_bars[i].set_value(task_iterate["progress"])
		reward_buttons[i].set_name(str(i))
#			print(reward_buttons[i].get_name())
		task_bar_labels[i].set_text(str(task_iterate["progress"] , " out of " , task_iterate["goal"]))
#	var task_bar_label = task_bar.get_node("ProgressLbl").get_text()
#	var split_str = task_bar_label.split(" ", true, 1)
#	task_bar.get_node("ProgressLbl").set_text(str(value ," ", split_str[1]))

#		task_desc = task["task_desc"]
#		reward = task_name["reward"]
#		reward_quantity = task_info["reward_quantity"]
#		progress = task_info["progress"]
#		goal = task_info["goal"]
#
#		tasktitles.append({
#			"task_desc": task_desc,
#			"reward": reward,
#			"reward_quantity": reward_quantity,
#			"progress": progress,
#			"goal": goal
#		})
func claim_attempt(task_clicked_index: int):
#	print(task_clicked_index)
	if task_bars[task_clicked_index].get_value() < task_bars[task_clicked_index].get_max() or claim_flags[task_clicked_index].button_pressed:
		Audio.play_sfx(Audio.close_btn_sfx)
		return#shakevibrate bar
	reward_buttons[task_clicked_index].disabled = true
	Audio.play_sfx(Audio.dt_claim_sfx)
	Game.user_inventory[reward_labels[task_clicked_index].get_text()] += int(reward_quantity_labels[task_clicked_index].get_text())
	Game.update_local_save()
	#verification if task is done
	#reward
	#change bar to buttond disabled = empty
	#img changechange in dt json



func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	queue_free()

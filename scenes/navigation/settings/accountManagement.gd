extends TextureButton

var isUserLoggedIn = false # change boolean if userIsLoggedIn
# (sa karon manual lng sa for testing)
# get_tree().change_scene_to_file("res://path/to/scene.tscn")

func _on_pressed():
	print('working')
	if isUserLoggedIn:
		# if true go to -> loggedIn scene
		get_tree().change_scene_to_file("res://scenes/navigation/settings/account_management/loggedIn.tscn")
	else:
		# if false go to -> notLoggedIn scene
		get_tree().change_scene_to_file("res://scenes/navigation/settings/account_management/notLoggedIn.tscn")

extends Node2D

func animate_object_found(object_found):
	var object_found_tween: Tween = create_tween()
	# basically these 5 'tweens' will play in sequence (sunod2, murag frame if nag animate)
	$"../ObjectFoundAnimation/CPUParticles2D2".emitting = true
	$"../ObjectFoundAnimation/CPUParticles2D2".color = "#f37cff"
	$"../ObjectFoundAnimation/CPUParticles2D2".position.x = object_found.position.x
	$"../ObjectFoundAnimation/CPUParticles2D2".position.y = object_found.position.y
	object_found_tween.tween_property(object_found, "scale", Vector2(1.1,1.1), 0.2) # has 4 parameters (object, property, final_val, duration)
	object_found_tween.tween_property(object_found, "scale", Vector2(1.2,1.2), 0.2)
	object_found_tween.tween_property(object_found, "scale", Vector2(1.3,1.3), 0.2)

	object_found_tween.tween_property(object_found, "scale", Vector2(0.6,0.6), 0.2) # shrinks the clicked object
	object_found_tween.tween_property(object_found, "scale", Vector2(0.5,0.5), 0.2) # also shrinks the object
#	object_found_tween.tween_property(object_found, "position", Vector2(500, 500), 3) # this line moves the clicked object down
	object_found_tween.finished.connect(object_found.queue_free) # this line of code removes the object 

func animate_object_clue(object_clue):
	var object_clue_tween: Tween = create_tween()
	$"../ObjectFoundAnimation/CPUParticles2D2".emitting = true
	$"../ObjectFoundAnimation/CPUParticles2D2".color = "#5f7cff"
	$"../ObjectFoundAnimation/CPUParticles2D2".position.x = object_clue.position.x
	$"../ObjectFoundAnimation/CPUParticles2D2".position.y = object_clue.position.y
	object_clue_tween.tween_property(object_clue, "scale", Vector2(1.25, 1.25), 0.5)
	object_clue_tween.tween_property(object_clue, "scale", Vector2(0.6,0.6), 0.5)
	object_clue_tween.tween_property(object_clue, "scale", Vector2(1.25, 1.25), 0.5)


func _on_game_scene_object_found_signal(object_name):
	Audio.play_object(Audio.object_audio[object_name.get_name()])
	var object_to_animate = object_name.duplicate()
	for node in object_to_animate.get_children():
		if node.is_class("CollisionPolygon2D"):
			node.queue_free()
	add_child(object_to_animate)
	object_name.queue_free() # remove 
	animate_object_found(object_to_animate) # calls the function above

func _on_hud_clue_pressed(object_clue):
	animate_object_clue(object_clue)

func _on_level_ready():
	pass # Replace with function body.

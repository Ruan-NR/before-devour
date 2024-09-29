extends Area2D

signal picked
var tool_picked = 0
signal needed 
var need
var collected = "0/4"
signal update 
var on_body = false

func _process(delta):
	collected = str(tool_picked) + "/4"
	if Input.is_action_just_pressed("ui_accept"):
		if on_body:
			emit_signal("update", collected, tool_picked)
			get_parent().get_node("UI/MarginContainer/HBoxContainer/Peças").text = "Peças: " + str(collected)
			if collected == "0/4" and tool_picked == 0:
				get_parent().get_node("UI/MarginContainer/VBoxContainer/pegue/AnimationPlayer").play("fade")

func _on_Machine_body_entered(body):
	print(tool_picked, "/4")
	print(collected)
	if body.name == "Player":
		$AnimatedSprite.play("white")
		get_parent().get_node("UI/enter").visible = true
		on_body = true
	if tool_picked == 4:
		$AnimatedSprite.play("active")
		$AnimatedSprite/Light2D.enabled = true
		$StaticBody2D/rampa.disabled = true
		$AudioStreamPlayer.play()
		$"/root/ScreenTransitionManager".transition_to_scene("res://scenes/Win.tscn")

func _on_Machine_body_exited(body):
	if tool_picked != 4:
		$AnimatedSprite.play("normal")
	get_parent().get_node("UI/enter").visible = false
	on_body = false

func _on_Player_pickup(picked):
	if typeof(picked) == TYPE_INT:
		if picked != tool_picked + 1:
			print("precisa de algo antes")
			emit_signal("needed", tool_picked, picked, collected)
			need = true
		else:
			tool_picked = picked
			need = false
			emit_signal("picked", tool_picked, picked, collected)
	else:
		pass


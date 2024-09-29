extends Area2D

signal picked 
var is_picked = false
var ever_picked = false
var needed = true
var tool_pickup = 0
var machine_collected = "0/4"
var tried = false

func _ready():
	pass 


func _process(delta):
	if is_picked == true and ever_picked != true:
			if Input.is_action_just_pressed("ui_accept"):
				if machine_collected == "2/4":
					emit_signal("picked")
					ever_picked = true
					visible = false
					$CollisionShape2D.disabled = true
				else:
					tried = true
		
	if tried:
		get_parent().get_node("UI/MarginContainer/VBoxContainer/ordem/AnimationPlayer").play("fade")
		tried = false

func _on_Screw_area_entered(area):
	is_picked = true
	$AnimatedSprite.play("white")
	get_parent().get_node("UI/enter").visible = true

func _on_Screw_area_exited(area):
	is_picked = false
	$AnimatedSprite.play("normal")
	get_parent().get_node("UI/enter").visible = false

func _on_Player_pickup(picked):
	if typeof(picked) == TYPE_INT:
		if picked == 3 and tool_pickup == picked - 1:
			needed = false

func _on_Machine_needed(tool_picked, picked, collected):
	if picked == 3:
		needed = true
		tool_pickup = tool_picked
		machine_collected = collected

func _on_Machine_picked(tool_picked, picked, collected):
	machine_collected = collected
	tool_pickup = tool_picked

func _on_Machine_update(collected, tool_picked):
	machine_collected = collected
	tool_pickup = tool_picked


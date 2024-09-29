extends Area2D


var tool_picked = 0
var already_tape = false
var entered = false

func _process(delta):
	if entered == true:
		if tool_picked == 1:
			if Input.is_action_just_pressed("ui_accept"):
				$AnimatedSprite.play("empty")
				$AnimatedSprite/Light2D.enabled = true
				already_tape = true
				tool_picked = 3
func _on_Lasergun_body_entered(body):
	entered = true

func _on_Lasergun_body_exited(body):
	entered = false

func _on_Player_pickup(picked):
	if typeof(picked) == TYPE_STRING:
		if picked == "tape":
			tool_picked = 1


func _on_Lasergun_area_entered(area):
	if already_tape == false:
		$AnimatedSprite.play("white")


func _on_Lasergun_area_exited(area):
	if already_tape == false:
		$AnimatedSprite.play("normal")








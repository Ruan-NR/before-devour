extends KinematicBody2D

const ACC = 500
const MAX_SPEED = 50
const FRICTION = 500
var vel = Vector2.ZERO
var moveDir = Vector2.ZERO
var playerSide =  Vector2.DOWN
var picked = 0
var tape = "notape"
signal pickup
var tool_picked = 0
var machine_collected = "0/4"

func _ready():
	pass 
	
func _process(delta):
	change_anim()
	moveDir = Input.get_vector("left", "right", "up", "down")
	moveDir = moveDir.normalized()
	
	if moveDir != Vector2.ZERO:
		vel = vel.move_toward(moveDir * MAX_SPEED, ACC * delta)
	else:
		vel = vel.move_toward(Vector2.ZERO, FRICTION * delta)
	

	vel = move_and_slide(vel)
	

func change_anim():
	if moveDir.x != 0:
		if moveDir.x > 0:
			$AnimatedSprite.play("side")
			$AnimatedSprite.flip_h = false
			playerSide = Vector2.RIGHT
		else:
			$AnimatedSprite.play("side")
			$AnimatedSprite.flip_h = true
			playerSide = Vector2.LEFT
	elif moveDir.y != 0:
		if moveDir.y > 0:
			$AnimatedSprite.play("run")
			playerSide = Vector2.DOWN
		else:
			$AnimatedSprite.play("back")
			playerSide = Vector2.UP
	else:
		change_idle()
		
func change_idle():
	if playerSide == Vector2.UP:
		$AnimatedSprite.play("idleback")
	elif playerSide == Vector2.DOWN:
		$AnimatedSprite.play("idlerun")
	else:
		$AnimatedSprite.play("idleside")

func _on_Area2D_picked():
	picked = 2
	emit_signal("pickup", picked)

func _on_tape_picked():
	tape = "tape"
	emit_signal("pickup", tape)

func _on_Gear_picked():
	picked = 1
	emit_signal("pickup", picked)

func _on_Machine_needed(tool_picked, picked, collected):
	machine_collected = collected

func _on_Screw_picked():
	picked = 3
	emit_signal("pickup", picked)

func _on_ScrewDriver_picked():
	picked = 4
	emit_signal("pickup", picked)

extends KinematicBody2D


onready var player : KinematicBody2D = get_parent().get_node("Player")
var path : Array = []
onready var navigation_path = get_parent().get_node("Pathfinder")
var vel = Vector2.ZERO
var speed = 40

func _physics_process(delta):
	if player and navigation_path:
		generate_path()
		navigate()
	vel = move_and_slide(vel)
	if vel.x < 0:
		$AnimatedSprite.play("side")
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_v = false
	if vel.x > 0:
		$AnimatedSprite.play("side")
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.flip_v = false

func generate_path():
	path = navigation_path.get_simple_path(global_position, player.global_position, false)
	
func navigate():
	if path.size() > 0:
		vel = global_position.direction_to(path[1]) * speed
		if global_position == path[0]:
			path.pop_front()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/Jumpscare.tscn")


func _on_Steps_finished():
	$TimerStep.start()


func _on_TimerStep_timeout():
	$Steps.play()

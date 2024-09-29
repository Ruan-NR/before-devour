extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.global_position.x = 379
	$Camera2D.global_position.y = -356
	$Yuri.playing = false
	$Miguel.playing = false
	$Yuri.frame = 1
	$Miguel.frame = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Control_finish():
	$AnimationPlayer.play("move")


func _on_AnimationPlayer_animation_finished(anim_name):
	$"/root/ScreenTransitionManager".transition_to_scene("res://scenes/World.tscn")

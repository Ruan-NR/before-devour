extends Area2D

signal picked 
var is_picked = false
var ever_picked = false

func _ready():
	pass 

func _process(delta):
	if is_picked == true and ever_picked != true:
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("picked")
			ever_picked = true
			visible = false

func _on_tape_area_entered(area):
	is_picked = true
	$AnimatedSprite.play("white")

func _on_tape_area_exited(area):
	is_picked = false
	$AnimatedSprite.play("normal")
	


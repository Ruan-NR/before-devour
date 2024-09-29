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
			$CollisionShape2D.disabled = true

func _on_Gear_area_entered(area):
	is_picked = true
	$AnimatedSprite.play("white")
	get_parent().get_node("UI/enter").visible = true


func _on_Gear_area_exited(area):
	is_picked = false
	$AnimatedSprite.play("normal")
	get_parent().get_node("UI/enter").visible = false

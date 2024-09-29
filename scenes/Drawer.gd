extends Area2D

signal picked 
var is_picked = false
var ever_picked = false
export(String, "tape", "screwdriver", "gear") var item = null

func _ready():
	if item == "tape":
		item_ready("tape")
	if item == "screwdriver":
		item_ready("ScrewDriver")
	if item == "gear":
		item_ready("Gear")


func _process(delta):
	if is_picked == true and ever_picked != true:
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("picked")
			ever_picked = true
			$AnimatedSprite.play("open")
			$CollisionShape2D.disabled = true
			if item == "tape":
				show_item("tape")
			if item == "screwdriver":
				show_item("ScrewDriver")
			if item == "gear":
				show_item("Gear")

func _on_Drawer_area_entered(area):
	is_picked = true
	if ever_picked == false:
		$AnimatedSprite.play("white")

func _on_Drawer_area_exited(area):
	is_picked = false
	if ever_picked == false:
		$AnimatedSprite.play("normal")
		
func item_ready(your_item):
	var item = get_parent().get_node(your_item)
	item.global_position.x = global_position.x
	item.global_position.y = global_position.y + 12
	item.visible = false
	item.get_node("CollisionShape2D").disabled = true

func show_item(your_item):
	var item = get_parent().get_node(your_item)
	item.visible = true
	item.get_node("CollisionShape2D").disabled = false

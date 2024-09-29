extends Camera2D

var TargetPos = Vector2.ZERO

export(Color, RGB) var background_color

func _ready():
	VisualServer.set_default_clear_color(background_color)

func _process(delta):
	acquire_targetPos()
	

func acquire_targetPos():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		TargetPos = player.global_position

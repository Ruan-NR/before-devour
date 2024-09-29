extends TextureRect

signal finish

export var dialogPath = ""
export(float) var textSpeed = textSpeed
export(String, "Ynormal, Ysmile, Mnormal, Msmile") var face = null

var dialog

var phraseNum = 0
var finished = false


func _ready():
	$Timer.wait_time = textSpeed
	dialog = get_dialog()
	assert(dialog, "Dialog Not Found")
	nextPhrase()

func _process(delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Texto.visible_characters = len($Texto.text)
func get_dialog():
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase():
	if phraseNum >= len(dialog):
		emit_signal("finish")
		get_parent().get_node("Foto").queue_free()
		queue_free()
		return
	
	finished = false
	
	$Nome.bbcode_text = dialog[phraseNum]["Nome"]
	$Texto.bbcode_text = dialog[phraseNum]["Texto"]
	
	$Texto.visible_characters = 0
	
	var f = File.new()
	var img = dialog[phraseNum]["Nome"] + "_" + dialog[phraseNum]["Emoção"] + ".png"
	get_owner().get_node("Foto").texture = load("res://assets/dialog_anims/player/" + str(img))
	
	while $Texto.visible_characters < len($Texto.text):
		$Texto.visible_characters += 1
		$AudioStreamPlayer.play()
		
		$Timer.start()
		yield($Timer, "timeout")
	finished = true
	phraseNum += 1
	return
	

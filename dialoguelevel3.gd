extends Control

signal dialogue_finished

@export_file("*.json") var d_file

var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false
	
func start():
	print("yes")
	if d_active:
		return 
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	for i in range(0,3):
		next_script()
		await get_tree().create_timer(1).timeout

func load_dialogue():
	var file = FileAccess.open("res://dialogue/text.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content		
		
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$NinePatchRect.visible = false
		emit_signal("dialogue_finished")
		return
	$NinePatchRect/text.text = dialogue[current_dialogue_id]['text']

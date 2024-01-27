extends StaticBody2D

signal openingdone

# Called when the node enters the scene tree for the first time.
func _ready():
	$SexyBubble1.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $SexyBubbleEnding.is_visible() and Input.is_action_pressed("ui_accept"):
		get_tree().quit()

func _on_person_image_change_view():
	if not $SexyBubbleEnding.is_visible():
		await get_tree().create_timer(0.5).timeout
		show()
		$InputBox.active = true


func _on_input_box_message(i):
	if i == 0:
		$PlayerBubble1.show()
		await get_tree().create_timer(0.5).timeout
		$SexyBubble2.show()
	elif i == 1:
		$PlayerBubble2.show()
		await get_tree().create_timer(0.5).timeout
		$SexyBubble3.show()
	elif i == 2:
		$PlayerBubble3.show()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://level_1.tscn")

extends StaticBody2D

var messageTexts = ["Hi","Hell yeah!","See you then!"]
var grey = Color(0.3,0.3,0.3,1.0)
var black = Color(0.0,0.0,0.0,1.0)
var i = 0
var active = false

signal message

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.set_text("Press Enter to type")
	$Label.set("theme_override_colors/font_color",grey)
	i = 0


# Called every frame. 'delta' is the0.3 elapsed time since the previous frame.
func _process(delta):
	if active and i < messageTexts.size():
		if Input.is_action_just_pressed("ui_accept"):
			active = false
			$Label.set_text("")
			$Label.set("theme_override_colors/font_color",black)
			for k in messageTexts[i]:
				$Label.set_text($Label.get_text() + k)
				await get_tree().create_timer(0.1).timeout
			await get_tree().create_timer(1).timeout
			message.emit(i)
			$Label.set("theme_override_colors/font_color",grey)
			$Label.set_text("Press Enter to type")
			i += 1
			active = true

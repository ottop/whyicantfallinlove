extends CharacterBody2D

var weatherControlNode
var storm_sound
var jump_sound

const SPEED = 800.0
const JUMP_VELOCITY = -900.0

var jumps_made = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var wind_strength = 0

func _ready():
	weatherControlNode = $"/root/Node2D/weather_control"
	storm_sound = $"/root/Node2D/storm_audio"  # Replace with the actual name of your AudioStreamPlayer node
	jump_sound = $"/root/Node2D/CharacterBody2D/jump"
	weatherControlNode.visible = true 

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta * 3
	else:
		jumps_made = 0

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jumps_made += 1
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and jumps_made < 2:
		jumps_made += 1
		velocity.y = JUMP_VELOCITY * 0.8
		jump_sound.play()

	# Handle wind effect
	if not is_on_floor() or Input.get_action_strength("ui_left") > 0 or Input.get_action_strength("ui_right") > 0:
		velocity.x = (wind_strength + Input.get_axis("ui_left", "ui_right")) * SPEED
		$AnimatedSprite2D.play("run")
	if Input.get_action_strength("ui_left") > 0:
		$AnimatedSprite2D.flip_h = true
	elif Input.get_action_strength("ui_right") > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = 0
		$AnimatedSprite2D.play("idle")
		
	if Input.is_action_pressed("run"):
		velocity.x = velocity.x * 1.5
		$AnimatedSprite2D.speed_scale = 1.5
		
	else:
		$AnimatedSprite2D.speed_scale = 1.0

	move_and_slide()

func _on_ending_area_body_entered(body):
	if body is CharacterBody2D:
		var hitbox = body.get_node("characterhitbox")
		if hitbox:
			get_tree().change_scene_to_file("res://datingappend.tscn")

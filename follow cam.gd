extends Camera2D

var camera_follow_speed = 0.1
var camera_offset = Vector2(0, 0)

func _process(delta):
	# Get the player's position
	var player_position = get_parent().global_position
	
	# Adjust camera position
	var target_x = player_position.x
	var target_y = player_position.y + camera_offset.y  # Adjust the Y offset as needed
	

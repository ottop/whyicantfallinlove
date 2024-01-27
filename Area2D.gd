extends Area2D



func _on_body_entered(body):
	if body is CharacterBody2D:
		var hitbox = body.get_node("characterhitbox")
		if hitbox:
			get_tree().change_scene_to_file("res://node_2d.tscn")

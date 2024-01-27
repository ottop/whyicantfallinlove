extends RigidBody2D

signal change_view

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		add_constant_force(Vector2.RIGHT*6)

func _on_phone_body_exited(body):
	queue_free()
	change_view.emit()

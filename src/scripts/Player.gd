extends Actor

# Adding the double jump
var jumps: int = 2

func _physics_process(delta: float) -> void:
	var direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		 -1.0 if Input.get_action_strength("jump") and canJump() else 1.0
	)
	velocity = speed * direction 
	velocity = move_and_slide(velocity)

func canJump():
	return is_on_floor()

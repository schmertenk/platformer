extends ControlPlatform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.control_platforms.S && Input.is_action_just_pressed("down"):
		for body in $Body/Area2D.get_overlapping_bodies():
			var vec = global_position.direction_to(body.global_position)
			if body is Player:
				body.apply_force(vec * 800 * Vector2(5,1))
			if body is RigidBody2D:
				body.apply_force(vec * 80000)

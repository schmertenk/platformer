extends ControlPlatform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.control_platforms.D && Input.is_action_just_pressed("right"):
		for body in $Body/Area2D.get_overlapping_bodies():
			if body is Player:
				body.apply_force(Vector2.UP * 800)
			if body is RigidBody2D:
				body.apply_force(Vector2.UP * 80000)

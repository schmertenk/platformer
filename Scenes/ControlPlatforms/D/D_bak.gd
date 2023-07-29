extends ControlPlatform

@export var speed = 150
@export var distance = 100
var direction = 1
	
func _process(delta):
	if Input.is_action_pressed("right") && Global.control_platforms.D:
		if abs(body.position.y) > distance:
			if direction == 1 && body.position.y > distance:
				direction = -1
			if direction == -1 && body.position.y < -distance:
				direction = 1
		body.position += delta * speed * direction * Vector2(0, 1)

func _on_area_2d_body_entered(other_body):
	if other_body is StaticBody2D || other_body is AnimatableBody2D:
		if other_body.global_position.y - body.global_position.y < 0 && direction < 0:
			direction = 1
		if other_body.global_position.y - body.global_position.y > 0 && direction > 0:
			direction = -1
	if other_body is RigidBody2D && other_body.freeze:
		if other_body.global_position.y - body.global_position.y < 0 && direction < 0:
			direction = 1
		if other_body.global_position.y - body.global_position.y > 0 && direction > 0:
			direction = -1

extends ControlPlatform

@export var speed = 150
@export var distance = 100
var direction = 1

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_pressed("left") && Global.control_platforms.A:
		if abs(body.position.x) > distance:
			if direction == 1 && body.position.x > distance:
				direction = -1
			if direction == -1 && body.position.x < -distance:
				direction = 1
		body.position += delta * speed * direction * Vector2(1, 0)

func _on_area_2d_body_entered(other_body):
	if other_body is StaticBody2D || other_body is AnimatableBody2D:
		if other_body.global_position.x - body.global_position.x < 0 && direction < 0:
			direction = 1
		if other_body.global_position.x - body.global_position.x > 0 && direction > 0:
			direction = -1
	if other_body is RigidBody2D && other_body.freeze:
		if other_body.global_position.x - body.global_position.x < 0 && direction < 0:
			direction = 1
		if other_body.global_position.x - body.global_position.x > 0 && direction > 0:
			direction = -1

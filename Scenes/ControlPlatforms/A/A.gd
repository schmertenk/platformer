extends ControlPlatform

@export var speed = 150
@export var distance = 100
var direction = 1

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_pressed("left") && Global.control_platforms.A:
		if abs($AnimatableBody2D.position.x) > distance:
			if direction == 1 && $AnimatableBody2D.position.x > distance:
				direction = -1
			if direction == -1 && $AnimatableBody2D.position.x < -distance:
				direction = 1
		$AnimatableBody2D.position += delta * speed * direction * Vector2(1, 0)

func _on_area_2d_body_entered(body):
	if body is StaticBody2D || body is AnimatableBody2D:
		if body.global_position.x - $AnimatableBody2D.global_position.x < 0 && direction < 0:
			direction = 1
		if body.global_position.x - $AnimatableBody2D.global_position.x > 0 && direction > 0:
			direction = -1
	if body is RigidBody2D && body.freeze:
		if body.global_position.x - $AnimatableBody2D.global_position.x < 0 && direction < 0:
			direction = 1
		if body.global_position.x - $AnimatableBody2D.global_position.x > 0 && direction > 0:
			direction = -1

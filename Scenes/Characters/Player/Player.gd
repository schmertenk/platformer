extends Character

class_name Player

@export var jump_buffer_time = 200
var jump_pressed_at = 0

func _physics_process(delta):
	get_input()
	apply_force(Vector2.DOWN * gravity * gravity_scale)
	apply_force(Vector2(velocity.x * -friction, 0))
	move()
	
func get_input():
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("right"):
		move_direction += Vector2.RIGHT
		
	if Input.is_action_pressed("left"):
		move_direction += Vector2.LEFT
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		else:
			jump_pressed_at = Time.get_ticks_msec()
	
	if jump_pressed_at and is_on_floor():
		if Time.get_ticks_msec() - jump_pressed_at <= jump_buffer_time:
			jump()
		jump_pressed_at = 0

			
		
	look_direction = global_position.direction_to(get_global_mouse_position())
	apply_force(move_direction.normalized() * speed)


func jump():
	apply_force(Vector2.UP * jump_force)

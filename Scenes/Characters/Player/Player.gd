extends Character

class_name Player

enum FLY_STATE {
	CAN_FLY,
	IN_FLIGHT,
	FLIGHT_ABORTED,
	CANT_FLY
}

@export var jump_buffer_time = 200

var jump_pressed_at = 0
var fly_state = FLY_STATE.CAN_FLY

func _physics_process(delta):
	get_input()
	apply_force(Vector2.DOWN * gravity * gravity_scale)
	apply_force(Vector2(velocity.x * -friction, 0))
	move()
	handle_animation()
	
	if fly_state != FLY_STATE.CAN_FLY and is_on_floor():
		fly_state = FLY_STATE.CAN_FLY
		$FlyTimer.paused = false
	
func get_input():
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("right") && !Global.control_platforms.D:
		move_direction += Vector2.RIGHT
		
	if Input.is_action_pressed("left") && !Global.control_platforms.A:
		move_direction += Vector2.LEFT
	
	if Input.is_action_pressed("jump"):
		if velocity.y > 0 and fly_state != FLY_STATE.CANT_FLY:
			if fly_state == FLY_STATE.CAN_FLY:
				fly_state = FLY_STATE.IN_FLIGHT
				$FlyTimer.start()
			if fly_state == FLY_STATE.FLIGHT_ABORTED:
				fly_state = FLY_STATE.IN_FLIGHT
				$FlyTimer.paused = false
			gravity_scale = 0
			velocity.y = 0

	if Input.is_action_just_released("jump"):
		if fly_state == FLY_STATE.IN_FLIGHT:
			gravity_scale = 3.0
			if $FlyTimer.time_left:
				$FlyTimer.paused = true
				fly_state = FLY_STATE.FLIGHT_ABORTED
			else:
				fly_state = FLY_STATE.CANT_FLY

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		else:
			jump_pressed_at = Time.get_ticks_msec()

	if jump_pressed_at and is_on_floor():
		if Time.get_ticks_msec() - jump_pressed_at <= jump_buffer_time:
			jump()
		jump_pressed_at = 0
		
	if Input.is_action_just_pressed("right_click"):
		var p = preload("res://Scenes/Projectiles/Projectile.tscn").instantiate()
		var direction = (get_global_mouse_position() - global_position).normalized()
		p.global_position = global_position + direction * 100
		Global.game.add_child(p)
		p.apply_force(direction * 17000)
		

	look_direction = global_position.direction_to(get_global_mouse_position())
	apply_force(move_direction.normalized() * speed)


func jump():
	apply_force(Vector2.UP * jump_force)
	var t = create_tween()
	t.set_trans(Tween.TRANS_SPRING)
	var full_rotations = int($Sprite2D.rotation_degrees / 360)
	var direction = 0
	if velocity.x < 0:
		direction = -1
	t.tween_property($Sprite2D, "rotation_degrees", 360 * (full_rotations + direction), 1)


func handle_animation():
	$Sprite2D.flip_h = velocity.x < 0
	if abs(velocity.x) > 50 and is_on_floor():
		$Sprite2D.rotate(sign(velocity.x) * (PI / 20))
	
	if fly_state == FLY_STATE.IN_FLIGHT:
		$AnimationPlayer.play("fly")
	else:
		$AnimationPlayer.play("RESET")


func _on_fly_timer_timeout():
	if fly_state == FLY_STATE.IN_FLIGHT:
		fly_state = FLY_STATE.CANT_FLY
		gravity_scale = 3.0

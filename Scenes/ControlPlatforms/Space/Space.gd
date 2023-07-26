extends ControlPlatform


func _ready():
		$RigidBody2D.freeze = true

func _process(delta):
	if $RigidBody2D.freeze && Global.control_platforms.Space && Input.is_action_just_pressed("jump"):
		$RigidBody2D.freeze = false
	if !$RigidBody2D.freeze && Global.control_platforms.Space && Input.is_action_just_released("jump"):
		$RigidBody2D.freeze = true

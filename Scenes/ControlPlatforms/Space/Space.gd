extends ControlPlatform


func _ready():
		body.freeze = true

func _process(delta):
	if body.freeze && Global.control_platforms.Space && Input.is_action_just_pressed("jump"):
		body.freeze = false
	if !body.freeze && Global.control_platforms.Space && Input.is_action_just_released("jump"):
		body.freeze = true

extends ControlPlatform

var can_freeze = true
var last_freeze_state:bool


func _ready():
	super()
	body.freeze = true

func _process(delta):
	if body.freeze && Global.control_platforms.Space && Input.is_action_just_pressed("jump"):
		body.freeze = false
	if !body.freeze && Global.control_platforms.Space && Input.is_action_just_released("jump") && can_freeze:
		body.freeze = true

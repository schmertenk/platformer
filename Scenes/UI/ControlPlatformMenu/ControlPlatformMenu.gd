extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for key in Global.game.available_control_platforms:
		var value = Global.game.available_control_platforms[key]
		get_node(key).visible = value

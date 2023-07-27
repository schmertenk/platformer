extends CenterContainer


@export var wrapper_path = ""
var enabled = true

func enable():
	enabled = true
	modulate = Color.WHITE
	
func disable():
	enabled = false
	modulate = Color.RED


func _on_button_button_down():
	if !enabled:
		return
	disable()
	var wrapper = load(wrapper_path).instantiate()
	Global.game.add_child(wrapper)
	wrapper.global_position = get_global_mouse_position()
	wrapper.drag()

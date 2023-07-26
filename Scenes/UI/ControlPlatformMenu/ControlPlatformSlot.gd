extends CenterContainer


@export var wrapper_path = ""


func _on_button_button_down():
	var wrapper = load(wrapper_path).instantiate()
	Global.game.add_child(wrapper)
	wrapper.global_position = get_global_mouse_position()
	wrapper.drag()

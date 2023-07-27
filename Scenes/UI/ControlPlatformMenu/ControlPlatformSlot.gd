extends CenterContainer


@export var wrapper_path = ""
var enabled = true
var platform_id
var hovered_wrapper:ControlPlatformWrapper = null

func _ready():
	pass
	
func enable():
	enabled = true
	modulate = Color.WHITE
	
func disable():
	enabled = false
	modulate = Color.RED
	
func _process(delta):
	if Input.is_action_just_released("click") and hovered_wrapper:
		hovered_wrapper.queue_free()
		enable()
		

func _on_button_button_down():
	if !enabled:
		return
	disable()
	var wrapper = load(wrapper_path).instantiate()
	Global.game.add_child(wrapper)
	wrapper.global_position = get_global_mouse_position()
	wrapper.drag()


func _on_area_2d_area_entered(area):
	var wrapper = area.get_parent()
	if wrapper is ControlPlatformWrapper:
		if wrapper.scene_file_path == wrapper_path:
			hovered_wrapper = wrapper


func _on_area_2d_area_exited(area):
	var wrapper = area.get_parent()
	if wrapper == hovered_wrapper:
		hovered_wrapper = null
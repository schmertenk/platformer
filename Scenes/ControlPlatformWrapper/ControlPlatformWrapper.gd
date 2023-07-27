extends Node2D

class_name ControlPlatformWrapper


@export var control_platform_path = ""

var control_platform:Node2D = null
var is_dragging = false
var mouse_in
var mouse_offset = Vector2.ZERO
var platform_id


func _ready():
	if control_platform_path:
		var platform = load(control_platform_path).instantiate()
		platform_id = platform.id
	
	
func _process(delta):
	if mouse_in and Input.is_action_just_pressed("click"):
		drag()
		mouse_offset = global_position - get_global_mouse_position()
	if mouse_in and Input.is_action_just_released("click"):
		drop()
		
	if is_dragging:
		global_position = get_global_mouse_position() + mouse_offset


func drag():
	if control_platform:
		Global.control_platforms[control_platform.id] = false
		control_platform.get_parent().remove_child(control_platform)
		control_platform.queue_free()
		control_platform = null

	$Sprite2D.visible = true
	is_dragging = true
	
func drop():
	var platform = load(control_platform_path).instantiate()
	control_platform = platform
	platform.wrapper = self
	Global.control_platforms[control_platform.id] = true
	Global.game.add_child(platform)
	platform.body.global_position = global_position
	platform.global_position = global_position
	is_dragging = false
	$Sprite2D.visible = false


func _on_area_2d_mouse_entered():
	mouse_in = true


func _on_area_2d_mouse_exited():
	mouse_in = false


func _on_tree_exiting():
	if control_platform:
		Global.control_platforms[control_platform.id] = false
		control_platform.queue_free()
		control_platform = null

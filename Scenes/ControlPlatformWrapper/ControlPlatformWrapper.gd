extends Node2D

class_name ControlPlatformWrapper

signal return_wrapper(wrapper)
@export var control_platform_path = ""

var control_platform:Node2D = null
var is_dragging = false
var mouse_in
var mouse_offset = Vector2.ZERO
var platform_id

var can_drop = true


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

	can_drop = true
	for area in $Area2D.get_overlapping_areas():
		if area and !area.is_in_group("passing_wrappers"):
			can_drop = false
	for body in $Area2D.get_overlapping_bodies():
		if body and !body.is_in_group("passing_wrappers"):
			can_drop = false
			
	if !can_drop:
		$Sprite2D.modulate = Color.ROSY_BROWN
	else:
		$Sprite2D.modulate = Color.WHITE
		


func drag():
	if control_platform:
		Global.control_platforms[control_platform.id] = false
		control_platform.get_parent().remove_child(control_platform)
		control_platform.queue_free()
		control_platform = null

	$Sprite2D.visible = true
	is_dragging = true
	
func drop():
	if can_drop:
		var platform = load(control_platform_path).instantiate()
		control_platform = platform
		platform.wrapper = self
		Global.control_platforms[control_platform.id] = true
		Global.game.add_child(platform)
		platform.global_position = global_position
		platform.body.global_position = global_position
		if platform.body is RigidBody2D:
			platform.body.global_rotation = global_rotation
		is_dragging = false
		$Sprite2D.visible = false
	else: 
		return_wrapper.emit(self)


func _on_area_2d_mouse_entered():
	mouse_in = true


func _on_area_2d_mouse_exited():
	mouse_in = false


func _on_tree_exiting():
	if control_platform:
		Global.control_platforms[control_platform.id] = false
		control_platform.queue_free()
		control_platform = null

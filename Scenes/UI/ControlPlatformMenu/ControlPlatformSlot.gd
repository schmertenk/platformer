extends CenterContainer


@export var wrapper_path = ""
@export var texture:Texture

var enabled = true
var platform_id
var hovered_wrapper:ControlPlatformWrapper = null
var current_wrapper

func _ready():
	$Button/TextureRect.texture = texture
	$Button/TextureRect.pivot_offset = $Button/TextureRect.size / 2
	$Area2D/CollisionShape2D.global_position = $Button/TextureRect.global_position + $Button/TextureRect.size
	$Area2D/CollisionShape2D.global_position -= Vector2(0, $Button/TextureRect.size.y / 2)
	
func enable():
	enabled = true
	modulate = Color.WHITE
	
func disable():
	enabled = false
	modulate = Color.RED
	
func _process(delta):
	if Input.is_action_just_released("click") and hovered_wrapper:
		return_wrapper(hovered_wrapper)
	
	if hovered_wrapper:
		$Button/TextureRect.scale = Vector2(1.1, 1.1)
	else:
		$Button/TextureRect.scale = Vector2(1, 1)

func return_wrapper(wrapper: ControlPlatformWrapper):
	if wrapper.is_dragging:
		var t = create_tween()
		t.set_trans(Tween.TRANS_EXPO)
		t.tween_property(wrapper, "global_position", global_position + size / 2, 0.5)
		await t.finished
	wrapper.queue_free()
	enable()

func _on_button_button_down():
	if !enabled:
		return_wrapper(current_wrapper)
	disable()
	var wrapper = load(wrapper_path).instantiate()
	Global.game.add_child(wrapper)
	wrapper.global_position = get_global_mouse_position()
	wrapper.return_wrapper.connect(return_wrapper)
	wrapper.drag()
	current_wrapper = wrapper


func _on_area_2d_area_entered(area):
	var wrapper = area.get_parent()
	if wrapper is ControlPlatformWrapper:
		if wrapper == current_wrapper:
			hovered_wrapper = wrapper


func _on_area_2d_area_exited(area):
	var wrapper = area.get_parent()
	if wrapper == hovered_wrapper:
		hovered_wrapper = null

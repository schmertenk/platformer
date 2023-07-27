extends Node2D

class_name ControlPlatform

@export var id = ""

@onready var body = $Body

var wrapper:ControlPlatformWrapper

func _ready():
	body.add_to_group("stickable")
	
func _physics_process(delta):
	if is_instance_valid(wrapper):
		wrapper.global_position = body.global_position
		wrapper.global_rotation = body.global_rotation

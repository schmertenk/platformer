extends Node2D

class_name ControlPlatform

@export var id = ""

@onready var body = $Body

var wrapper:ControlPlatformWrapper

func _physics_process(delta):
	if wrapper:
		wrapper.global_position = body.global_position
		wrapper.global_rotation = body.global_rotation

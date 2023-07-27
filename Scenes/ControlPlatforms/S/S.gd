extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.control_platforms.S && Input.is_action_just_pressed("down"):
		for body in $Body/Area2D.get_overlapping_bodies():
			if body is CharacterBody2D:
				body.apply_force(Vector2(0, -1000))
			if body is RigidBody2D:
				body.apply_force(Vector2(0, -100000))

extends Node2D

signal bloomed
var blooming = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if !blooming and body is Player:
		bloom()

func bloom():
	$Area2D/Sprite2D.modulate = Color(255, 0, 0)
	blooming = true
	bloomed.emit()

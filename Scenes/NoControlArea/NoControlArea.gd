extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.size = $CollisionShape2D.shape.size
	$ColorRect.global_position = $CollisionShape2D.global_position - $ColorRect.size / 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

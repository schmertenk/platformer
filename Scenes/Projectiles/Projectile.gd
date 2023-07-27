extends RigidBody2D

var direction


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var b = get_colliding_bodies()
	if b:
		var body = b[0]
		if !body is Player:
			var honey = preload("res://Scenes/Honey/Honey.tscn").instantiate()
			body.add_child(honey)
			honey.global_position = global_position
			honey.node_a = honey.get_path_to(body)
			honey.offset = global_position - body.global_position
			queue_free()
		

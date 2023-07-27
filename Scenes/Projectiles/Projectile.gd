extends RigidBody2D


signal hit(honey)

var direction


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _integrate_forces(state):
	var i = 0
	var b = get_colliding_bodies()
	if b:
		var body = b[0]
		if !body is Player:
			var honey = preload("res://Scenes/Honey/Honey.tscn").instantiate()
			await get_tree().create_timer(0.01).timeout
			body.add_child(honey)
			honey.global_position = global_position
			honey.node_a = honey.get_path_to(body)
			hit.emit(honey)
			queue_free()
			honey.rotation = state.get_contact_local_normal(0).angle() + PI / 2
		
		

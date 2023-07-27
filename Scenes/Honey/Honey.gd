extends PinJoint2D


class_name Honey

func _on_area_2d_body_entered(body):
	if get_path_to(body) != node_a and body.is_in_group("stickable"):
		add_stickable(body)


func add_stickable(body):
	node_b = get_path_to(body)
	var bodies = [get_node(node_a), get_node(node_b)]
	for b in bodies:
		if b and b is RigidBody2D:
			b.set_deferred("lock_rotation", true)
			b.freeze = false
			if b.get_parent() is ControlPlatform:
				b.get_parent().can_freeze = false


func remove_stickable():
	var bodies = [node_a, node_b]
	for path in bodies:
		if !has_node(path):
			continue
		var body = get_node(path)
		if body and body is RigidBody2D:
			body.set_deferred("lock_rotation", false)
			body.freeze = true
			if body.get_parent() is ControlPlatform:
				body.get_parent().can_freeze = true

	node_a = ""
	node_b = ""

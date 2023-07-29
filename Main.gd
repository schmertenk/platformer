extends Node2D

class_name Main

@onready var current_scene = $CurrentScene

func _ready():
	Global.main = self
	change_scene("res://Scenes/Menus/MainMenu/MainMenu.tscn")


func change_scene_to_instance(instanced_scene : Node, animation_speed = 1):
	$AnimationPlayer.play("trans_in")
	
	await $AnimationPlayer.animation_finished
	
	if current_scene.get_child_count():
		for s in current_scene.get_children():
			current_scene.remove_child(s)
			s.queue_free()
	current_scene.add_child(instanced_scene)
	$AnimationPlayer.play("trans_out")
	get_tree().paused = false
	
	
func change_scene(scene_path : String):
	var i = load(scene_path).instantiate()
	change_scene_to_instance(i)
	

func change_scene_to(scene : PackedScene):
	var instance = scene.instantiate()
	change_scene_to_instance(instance)

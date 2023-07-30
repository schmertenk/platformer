extends Node


var wait_for_ok = false
var current_step = 0
var level

func _ready():
	get_tree().paused = true
	await get_tree().create_timer(0.5).timeout
	progress_tutorial(1)
	level = get_parent()
	
	
func _input(event):
	if event.is_action_pressed("tutorial_progress") and wait_for_ok:
		match current_step: 
			1, 2,4, 5, 6, 7,8 ,9 , 10, 11, 12, 13, 14, 16, 17, 18:
				progress_tutorial(current_step + 1)



func progress_tutorial(step):
	current_step = step
	for label in $Control/Texts.get_children():
		label.visible = false
		label.visible_ratio = 0.0
	
	if has_node("Control/Texts/" + str(step)):
		get_node("Control/Texts/" + str(step)).visible_ratio = 0.0
		get_node("Control/Texts/" + str(step)).visible = true
		var t = create_tween()
		t.tween_property(get_node("Control/Texts/" + str(step)), "visible_ratio", 1.0, 0.8)
	print(current_step)
	match step:
		1, 2, 5, 6, 7,8 ,9 , 10, 11, 12, 13, 14, 16, 17, 18:
			$Spotlight.visible = true
			wait_for_ok = true
			get_tree().paused = true
			
		3:
			$Spotlight.visible = false
			get_tree().paused = false
		4:
			$AnimationPlayer.play("4")
			$Spotlight.visible = true
			wait_for_ok = true
			get_tree().paused = true
			wait_for_ok = true
		15:
			$Spotlight.visible = false
			get_tree().paused = false
		19:
			$Spotlight.visible = false
			get_tree().paused = false
			Global.main.change_scene("res://Scenes/Menus/MainMenu/MainMenu.tscn")
		
			

func _on_flower_bloomed():
	if level.get_node("Flowers/Flower3").blooming:
		progress_tutorial(current_step + 1)


func _on_flower_2_bloomed():
	progress_tutorial(current_step + 1)

func _on_flower_3_bloomed():
	if level.get_node("Flowers/Flower").blooming:
		progress_tutorial(current_step + 1)

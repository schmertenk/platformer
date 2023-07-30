extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Global.main.change_scene("res://Scenes/Menus/LevelSelectMenu/LevelSelectMenu.tscn")


func _on_button_2_pressed():	
	Global.main.change_scene("res://Scenes/Levels/Tutorial/TutorialLevel1.tscn")

extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Global.main.change_scene("res://Scenes/Levels/Level1/Level1.tscn")


func _on_button_2_pressed():
	Global.main.change_scene("res://Scenes/Levels/Level2/Level2.tscn")


func _on_button_3_pressed():
	Global.main.change_scene("res://Scenes/Levels/Level3.tscn")


func _on_button_4_pressed():
	Global.main.change_scene("res://Scenes/Levels/Level4.tscn")

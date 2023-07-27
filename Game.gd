extends Node2D

class_name Game

var nr_of_blooming_flowers = 0
var nr_of_flowers = 0

func _ready():
	find_nr_of_flowers(self)
	print(nr_of_flowers)
	

func _init():
	Global.game = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func win():
	get_tree().quit()

func find_nr_of_flowers(node: Node) -> void:
	if node is Flower:
		nr_of_flowers += 1
		node.bloomed.connect(add_one_bloom)
	for child in node.get_children():
		find_nr_of_flowers(child)

func add_one_bloom():
	nr_of_blooming_flowers += 1
	if nr_of_blooming_flowers == nr_of_flowers:
		win()

extends CharacterBody2D

class_name Character

signal died
signal health_updated

@export var speed = 175
@export var jump_force = 520
@export var max_health = 2.0
@export var gravity_scale = 1.0

var friction = 0.3

var look_direction = Vector2.ZERO
var dead = false
var move_direction
var is_in_pool = false

var gravity = Global.gravity

var health:float:
	set(value): 
		health = value
		emit_signal("health_updated")
	get: return health


func _ready():
	health = max_health
	
func move():
	move_and_slide()

func apply_force(force:Vector2):
	velocity += force
	
func take_damage(amount, _dealer):
	self.health -= amount
	if health <= 0:
		die()

func die():
	if !dead:
		dead = true
		emit_signal("died", self)
		queue_free()


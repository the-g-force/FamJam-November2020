class_name Player
extends KinematicBody2D

signal destroyed

export var speed := 200
export var ship_variant := 0 setget _set_ship_variant

onready var _sprite := $Sprite

func _ready():
	_sprite.texture = Gamestats.ship_texture
	

func _physics_process(delta):
	var velocity := 0
	if Input.is_action_pressed("Left"):
		velocity -= 1
	if Input.is_action_pressed("Right"):
		velocity += 1
	if Input.is_action_just_pressed("Shoot"):
		var Laser:Area2D = load("res://src/Laser.tscn").instance()
		Laser.good = true
		Laser.global_position = $Muzzle.get_global_transform().origin
		get_parent().add_child(Laser)
	var _error = move_and_collide(Vector2(velocity, 0)*delta*speed)


func hit():
	Gamestats.health -= 1
	if Gamestats.health <= 0:
		emit_signal("destroyed")
		var explosion:Node2D = load("res://src/ExplosionParticles.tscn").instance()
		explosion.position = self.get_global_transform().origin
		get_tree().current_scene.add_child(explosion)
		queue_free()
	else:
		var explosion:Node2D = load("res://src/DamageExplosion.tscn").instance()
		explosion.position = self.get_global_transform().origin
		get_tree().current_scene.add_child(explosion)


func _set_ship_variant(value:int)->void:
	_sprite.frame = value

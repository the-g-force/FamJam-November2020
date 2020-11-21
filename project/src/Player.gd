class_name Player
extends KinematicBody2D

signal destroyed

export var speed := 200
export var cooldown := 0.4

var _can_shoot := true

onready var _sprite := $Sprite
onready var _shoot_sound := $ShootSound
onready var _hit_sound := $HitSound
onready var _shoot_cooldown := $ShootCooldown

func _ready():
	_sprite.texture = Gamestats.ship_texture
	Gamestats.player = self
	

func _physics_process(delta):
	var velocity := 0
	if Input.is_action_pressed("Left"):
		velocity -= 1
	if Input.is_action_pressed("Right"):
		velocity += 1
	if Input.is_action_just_pressed("Shoot") and _can_shoot:
		_can_shoot = false
		_shoot_cooldown.wait_time = cooldown
		_shoot_cooldown.start()
		_shoot_sound.play()
		var Laser:Area2D = load("res://src/Laser.tscn").instance()
		Laser.good = true
		Laser.global_position = $Muzzle.get_global_transform().origin
		get_parent().add_child(Laser)
	var _error = move_and_collide(Vector2(velocity, 0)*delta*speed)


func can_shoot()->bool:
	return _can_shoot


func hit():
	Gamestats.health -= 1
	if Gamestats.health <= 0:
		emit_signal("destroyed")
		var explosion:Node2D = load("res://src/ExplosionParticles.tscn").instance()
		explosion.position = self.get_global_transform().origin
		Gamestats.player = null
		get_tree().current_scene.add_child(explosion)
		queue_free()
	else:
		_hit_sound.play()
		var explosion:Node2D = load("res://src/DamageExplosion.tscn").instance()
		explosion.position = self.get_global_transform().origin
		get_tree().current_scene.add_child(explosion)
		


func _set_ship_variant(value:int)->void:
	_sprite.frame = value


func _on_ShootCooldown_timeout():
	_can_shoot = true

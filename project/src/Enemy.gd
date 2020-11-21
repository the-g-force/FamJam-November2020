class_name Enemy extends KinematicBody2D

const MIN_SHOOT_RATE := 0.2
const MAX_SHOOT_RATE := 1.0
const SECONDS_TO_MAX_RATE := 60.0

onready var _sprite := $Sprite
onready var _shoot_sound := $ShootSound

signal destroyed

export var base_shoot_speed := 5.0

var type := -1

func _ready():
	_sprite.play(str(type))
	_start_shoot_timer()


func hit():
	emit_signal("destroyed")
	Gamestats.score += 100
	var explosion:Node2D = load("res://src/ExplosionParticles.tscn").instance()
	explosion.position = self.get_global_transform().origin
	get_tree().current_scene.add_child(explosion)
	queue_free()


func _on_Timer_timeout():
	_shoot_sound.play()
	var Laser:Area2D = load("res://src/Laser.tscn").instance()
	Laser.position = $Muzzle.get_global_transform().origin
	Laser.good = false
	get_tree().current_scene.add_child(Laser)
	_start_shoot_timer()


func _start_shoot_timer():
	var rate := range_lerp(Gamestats.seconds_elapsed, 0, SECONDS_TO_MAX_RATE, MIN_SHOOT_RATE, MAX_SHOOT_RATE)
	var delay := 1/rate
	var randomness := randf()*-1.0 if randi()%2 == 0 else 1.0
	$Timer.start(delay-randomness)

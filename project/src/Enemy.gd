class_name Enemy extends Area2D

onready var _sprite := $Sprite
onready var _shoot_sound := $ShootSound

signal destroyed

export var base_shoot_speed := 3.0

var type := -1

func _ready():
	_sprite.play(str(type))
	_start_shoot_timer()


func hit():
	emit_signal("destroyed")
	Gamestats.score += 1
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
	$Timer.start(base_shoot_speed+randf()*-1.0 if randi()%2 == 0 else 1.0)

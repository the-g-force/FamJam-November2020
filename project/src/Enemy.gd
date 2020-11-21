class_name Enemy extends Area2D

onready var sprite := $Sprite

signal destroyed

export var base_shoot_speed := 3.0

var type := -1

func _ready():
	sprite.play(str(type))
	_start_shoot_timer()


func _on_Enemy_area_entered(_area):
	emit_signal("destroyed")
	Gamestats.score += 1
	var explosion:Node2D = load("res://src/ExplosionParticles.tscn").instance()
	explosion.position = self.get_global_transform().origin
	get_tree().current_scene.add_child(explosion)
	queue_free()


func _on_Timer_timeout():
	var Laser:Area2D = load("res://src/Laser.tscn").instance()
	Laser.position = $Muzzle.get_global_transform().origin
	Laser.good = false
	get_tree().current_scene.add_child(Laser)
	_start_shoot_timer()


func _start_shoot_timer():
	$Timer.start(base_shoot_speed+randf()*-1.0 if randi()%2 == 0 else 1.0)

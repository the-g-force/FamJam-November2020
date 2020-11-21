class_name Enemy extends Area2D

signal destroyed

export var base_shoot_speed := 3.0

func _ready():
	_start_shoot_timer()


func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.lightblue)


func _on_Enemy_area_entered(_area):
	emit_signal("destroyed")
	Gamestats.score += 1
	queue_free()


func _on_Timer_timeout():
	var Laser:Area2D = load("res://src/Laser.tscn").instance()
	Laser.position = $Muzzle.get_global_transform().origin
	Laser.good = false
	get_tree().current_scene.add_child(Laser)
	_start_shoot_timer()


func _start_shoot_timer():
	$Timer.start(base_shoot_speed+randf()*-1.0 if randi()%2 == 0 else 1.0)

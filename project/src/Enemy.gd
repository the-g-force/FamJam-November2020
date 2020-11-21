class_name Enemy extends Area2D

signal destroyed

func _ready():
# warning-ignore:incompatible_ternary
	_start_shoot_timer()

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.lightblue)


func _on_Enemy_area_entered(_area):
	emit_signal("destroyed")
	queue_free()


func _on_Timer_timeout():
	var Laser:Area2D = load("res://src/Laser.tscn").instance()
	Laser.position = $Muzzle.get_global_transform().origin
	Laser.good = false
	get_tree().current_scene.add_child(Laser)
	_start_shoot_timer()


func _start_shoot_timer():
	$Timer.start(2.0+randf()*-1.0 if randi()%2 == 0 else 1.0)

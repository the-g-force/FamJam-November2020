class_name Enemy extends Area2D

signal destroyed

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.lightblue)


func _on_Enemy_area_entered(_area):
	emit_signal("destroyed")
	queue_free()

extends Area2D

var good := true
export var speed := 400.0

func _process(delta):
	position.y += speed*delta*-1 if good else speed*delta


func _on_Laser_body_entered(body):
	if body is Player and not good:
		body.hit()
	queue_free()


func _draw():
	draw_rect(Rect2(Vector2(-1.25,-2.5), Vector2(2.5,5)), Color.red)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

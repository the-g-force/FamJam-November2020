extends Area2D

var good := true
export var speed := 400.0

func _process(delta):
	position.y += speed*delta*-1 if good else speed*delta


func _on_Laser_body_entered(body):
	if body is Player and not good:
		print("Hit player")
#	elif body is Enemy and good:
#		print("Hit enemy")


func _draw():
	draw_rect(Rect2(Vector2(-1.25,-2.5), Vector2(2.5,5)), Color.red)

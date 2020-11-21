extends KinematicBody2D

export var speed := 200

func _physics_process(delta):
	var velocity := 0
	if Input.is_action_pressed("Left"):
		velocity -= 1
	if Input.is_action_pressed("Right"):
		velocity += 1
	var _error = move_and_collide(Vector2(velocity, 0)*delta*speed)

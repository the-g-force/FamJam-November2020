extends Node2D


func _ready():
	$CPUParticles2D.orbit_velocity = -0.5 if randi()%2 == 0 else 0.5


func _on_Timer_timeout():
	queue_free()

extends Node2D

onready var _shoot_button : Button = $Shoot


func _process(_delta):
	if Gamestats.health < 5:
		$Health.get_node("Sprite"+str(Gamestats.health+1)).hide()
	elif Gamestats.health == 5:
		for heart in $Health.get_children():
			heart.show()
	$Score.text = str(Gamestats.score)
	_shoot_button.disabled = not Gamestats.player.can_shoot()


func _on_Shoot_pressed():
	Input.action_press("Shoot")


func _on_Right_button_down():
	Input.action_press("Right")


func _on_Left_button_down():
	Input.action_press("Left")


func _on_Left_button_up():
	Input.action_release("Left")


func _on_Right_button_up():
	Input.action_release("Right")

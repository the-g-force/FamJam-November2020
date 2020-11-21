extends Node2D


func _process(_delta):
	if Gamestats.health < 5:
		$Health.get_node("Sprite"+str(Gamestats.health+1)).hide()
	$Score.text == str(Gamestats.score)


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

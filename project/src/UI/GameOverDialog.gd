extends VBoxContainer

func _on_MainMenuButton_pressed():
	var next_scene = load("res://src/UI/MenuScene.tscn")
	get_tree().change_scene_to(next_scene)

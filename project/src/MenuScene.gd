extends Control

export var GameLevel : PackedScene = load("res://src/TestLevel.tscn")

func _on_PlayButton_pressed():
	var error := get_tree().change_scene_to(GameLevel)
	if error:
		print('Error changing scene: %s' % str(error))

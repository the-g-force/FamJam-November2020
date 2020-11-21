extends Control

export var MenuScene : PackedScene = preload("res://src/MenuScene.tscn")

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var error := get_tree().change_scene_to(MenuScene)
		if error:
			print("Error loading scene: %s" % str(error))

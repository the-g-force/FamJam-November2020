extends Control

export var GameLevel : PackedScene = load("res://src/TestLevel.tscn")

onready var _ship_container := $ShipContainer

func _ready():
	for ship_button in _ship_container.get_children():
		ship_button.connect("pressed", self, "_on_ShipButton_pressed", [ship_button])


func _on_ShipButton_pressed(ship_button)->void:
	var selected_texture : Texture = ship_button.texture_normal
	Gamestats.ship_texture = selected_texture
	var error := get_tree().change_scene_to(GameLevel)
	if error:
		print('Error changing scene: %s' % str(error))


func _on_FullscreenButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed

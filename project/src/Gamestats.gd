extends Node

var health := 5
var score := 0
var seconds_elapsed := 0.0

var player : Player 

var ship_texture : Texture = preload("res://assets/images/hero-ships/009.png")

func _ready():
	randomize()

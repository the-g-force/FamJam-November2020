extends Node2D

signal completed

export var SPEED := 100

export var Enemy : PackedScene = preload("res://src/Enemy.tscn")


var _path_list : Array = [
	load("res://src/Paths/RightToEdge.gd"),
	load("res://src/Paths/Down.gd"),
	load("res://src/Paths/LeftToEdge.gd"),
	load("res://src/Paths/Down.gd")
]
var _path : PathElement
var _path_index := 0

onready var _spawn_points := $SpawnPoints
onready var _enemies := $Enemies
var _enemies_left := 0

func _ready():
	for spawn_point in _spawn_points.get_children():
		var enemy : Enemy = Enemy.instance()
		enemy.position = spawn_point.position
		_enemies.add_child(enemy)
		_enemies_left += 1
		var _ignored := enemy.connect("destroyed", self, "_on_Enemy_destroyed", [], CONNECT_ONESHOT)
		

func _on_Enemy_destroyed():
	_enemies_left -= 1
	if _enemies_left == 0:
		print("All enemies in this wave are destroyed")
		emit_signal("completed")


func _physics_process(delta):
	if _path==null:
		_path = _path_list[_path_index].new()
	var done := _path.execute(_enemies.get_children(), delta)
	if done:
		_path_index = (_path_index + 1) % _path_list.size()
		_path = _path_list[_path_index].new()

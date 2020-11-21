extends Node2D

signal completed


const DOWN := preload("res://src/Paths/Down.gd")
const LEFT_TO_EDGE := preload("res://src/Paths/LeftToEdge.gd")
const RIGHT_TO_EDGE := preload("res://src/Paths/RightToEdge.gd")
const PATH_OPTIONS = [
	[DOWN, LEFT_TO_EDGE, DOWN, RIGHT_TO_EDGE],
	[DOWN, RIGHT_TO_EDGE, DOWN, LEFT_TO_EDGE]
]

export var SPEED := 100
export var Enemy : PackedScene = preload("res://src/Enemy.tscn")

var _path_list : Array = PATH_OPTIONS[randi() % PATH_OPTIONS.size()]
var _path : PathElement
var _path_index := 0

onready var _spawn_points := $SpawnPoints
onready var _enemies := $Enemies
var _enemies_left := 0

func _ready():
	var type := randi()%9
	for spawn_point in _spawn_points.get_children():
		var enemy : Enemy = Enemy.instance()
		enemy.position = spawn_point.position
		enemy.type = type
		_enemies.call_deferred("add_child", enemy)
		_enemies_left += 1
		var _ignored := enemy.connect("destroyed", self, "_on_Enemy_destroyed", [], CONNECT_ONESHOT)
		

func _on_Enemy_destroyed():
	_enemies_left -= 1
	if _enemies_left == 0:
		print("All enemies in this wave are destroyed")
		emit_signal("completed")
		queue_free()


func _physics_process(delta):
	if _path==null:
		_path = _path_list[_path_index].new()
	var done := _path.execute(_enemies.get_children(), delta*SPEED)
	if done:
		_path_index = (_path_index + 1) % _path_list.size()
		_path = _path_list[_path_index].new()

extends Node2D

export var SPEED := 100

export var Enemy : PackedScene = preload("res://src/Enemy.tscn")

onready var _spawn_points := $SpawnPoints
onready var _enemies := $Enemies

func _ready():
	for spawn_point in _spawn_points.get_children():
		var enemy := Enemy.instance()
		enemy.position = spawn_point.position
		_enemies.add_child(enemy)


# Move all the things downward.
#
# This could later be extracted to a separate script so that 
# waves could be random in shape and behavior.
func _physics_process(delta):
	for enemy in _enemies.get_children():
		enemy.position.y += SPEED * delta

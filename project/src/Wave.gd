extends Node2D

signal completed

export var SPEED := 100

export var Enemy : PackedScene = preload("res://src/Enemy.tscn")

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


# Move all the things downward.
#
# This could later be extracted to a separate script so that 
# waves could be random in shape and behavior.
func _physics_process(delta):
	for enemy in _enemies.get_children():
		enemy.position.y += SPEED * delta

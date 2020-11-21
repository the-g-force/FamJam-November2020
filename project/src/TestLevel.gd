extends Node2D


var wave_list := [
	load("res://src/Waves/Wave.tscn"),
	load("res://src/Waves/Wave2.tscn")
]

onready var _wave_spawn_point := $WaveSpawnPoint
onready var _player := $Player
onready var _game_over_dialog := $GameOverDialog


func _ready():
	_spawn_wave()
	var _error = _player.connect("destroyed", self, "_on_Player_destroyed", [], CONNECT_ONESHOT)


func _spawn_wave():
	var Wave:Node2D = wave_list[randi()%wave_list.size()].instance()
	Wave.position = _wave_spawn_point.get_global_transform().origin
	var _error = Wave.connect("completed", self, "_wave_over")
	$Waves.add_child(Wave)


func _wave_over():
	_spawn_wave()


func _on_Player_destroyed():
	_game_over_dialog.visible = true

extends Node2D

onready var _wave_spawn_point := $WaveSpawnPoint

var wave_list := [
	load("res://src/Wave.tscn")
]

func _ready():
	_spawn_wave()


func _spawn_wave():
	var Wave:Node2D = wave_list[randi()%wave_list.size()].instance()
	Wave.position = _wave_spawn_point.get_global_transform().origin
	var _error = Wave.connect("completed", self, "_wave_over")
	$Waves.add_child(Wave)

func _wave_over():
	_spawn_wave()

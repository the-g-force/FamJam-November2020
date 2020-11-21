extends Node2D


const WAVE_LIST := [
	preload("res://src/Waves/Wave_3_Enemies.tscn"),
	preload("res://src/Waves/Wave_4_Enemies.tscn")
]

onready var _wave_spawn_point := $WaveSpawnPoint
onready var _player := $Player
onready var _game_over_dialog := $GameOverDialog


func _ready():
	_spawn_wave()
	Gamestats.seconds_elapsed = 0
	var _error = _player.connect("destroyed", self, "_on_Player_destroyed", [], CONNECT_ONESHOT)


func _spawn_wave():
	var index := randi()%WAVE_LIST.size()
	var Wave:Node2D = WAVE_LIST[index].instance()
	Wave.position = _wave_spawn_point.get_global_transform().origin
	var _error = Wave.connect("completed", self, "_wave_over")
	$Waves.add_child(Wave)


func _process(delta):
	Gamestats.seconds_elapsed += delta


func _wave_over():
	_spawn_wave()


func _on_Player_destroyed():
	_game_over_dialog.visible = true

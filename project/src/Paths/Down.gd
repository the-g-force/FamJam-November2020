extends PathElement

const SPEED := 100

var _distance := 0.0

func execute(enemies:Array, delta:float)->bool:
	_distance += SPEED * delta
	for enemy in enemies:
		enemy.position.y += (SPEED+Gamestats.seconds_elapsed*10.0) * delta
	return _distance >= 100

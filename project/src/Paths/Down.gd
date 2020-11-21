extends PathElement

const SPEED := 100

var _distance := 0.0

func execute(enemies:Array, delta:float)->bool:
	_distance += SPEED * delta
	for enemy in enemies:
		enemy.position.y += SPEED * delta
	return _distance >= 100

extends PathElement

const SPEED := 100

var _distance := 0.0

func execute(enemies:Array, distance:float)->bool:
	_distance += distance
	for enemy in enemies:
		enemy.position.y += distance
	return _distance >= 100

extends PathElement

const MIN_X := 40
const SPEED := 100

func execute(enemies:Array, delta:float)->bool:
	var minimum : float = enemies[0].get_global_transform().origin.x
	for enemy in enemies:
		enemy.position.x -= (SPEED+Gamestats.seconds_elapsed*10.0) * delta
		minimum = min(minimum, enemy.get_global_transform().origin.x)
		
	return minimum <= MIN_X

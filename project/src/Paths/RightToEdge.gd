extends PathElement

const MAX_X := 440
const SPEED := 100

func execute(enemies:Array, delta:float)->bool:
	var maximum : float = 0
	for enemy in enemies:
		enemy.position.x += (SPEED+Gamestats.time*10.0) * delta
		maximum = max(maximum, enemy.get_global_transform().origin.x)
		
	return maximum >= MAX_X

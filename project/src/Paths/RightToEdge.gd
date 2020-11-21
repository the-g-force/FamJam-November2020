extends PathElement

const MAX_X := 440

func execute(enemies:Array, distance:float)->bool:
	var maximum : float = 0
	for enemy in enemies:
		enemy.position.x += distance
		maximum = max(maximum, enemy.get_global_transform().origin.x)
		
	return maximum >= MAX_X

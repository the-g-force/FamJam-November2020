extends PathElement

const MIN_X := 40

func execute(enemies:Array, distance:float)->bool:
	var minimum : float = enemies[0].get_global_transform().origin.x
	for enemy in enemies:
		enemy.position.x -= distance
		minimum = min(minimum, enemy.get_global_transform().origin.x)
		
	return minimum <= MIN_X

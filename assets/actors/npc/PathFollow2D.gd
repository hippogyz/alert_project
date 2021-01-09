extends PathFollow2D

export var velocity : float = 300.0
var direction = 1

func _process(delta: float) -> void:
	offset += delta * velocity * direction
	
	if unit_offset == 1:
		direction = -1
	if unit_offset == 0:
		direction = 1

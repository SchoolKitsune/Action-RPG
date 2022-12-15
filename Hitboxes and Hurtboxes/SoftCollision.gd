extends Area2D
# the purpose of this script is to detect other bats and then make them not overlap

func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0

func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if is_colliding():
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position) #the area we are colliding with
		push_vector = push_vector.normalized()
	return push_vector

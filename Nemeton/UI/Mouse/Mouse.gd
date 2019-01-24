extends Light2D

func _input(event):
	if event is InputEventMouseMotion:
        position = get_global_mouse_position()


func _process(delta):
	energy = rand_range(0.95, 1.05)
	var new_scale = rand_range(3.9, 4.1)
	scale = Vector2(new_scale, new_scale)
	rotation += rand_range(-0.005, 0.005)
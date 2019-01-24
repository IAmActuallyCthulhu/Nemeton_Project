extends Node2D

var pos = []

func _process(delta):
	update()

func _draw():
	if pos.size() > 2:
		draw_multiline(PoolVector2Array(pos), Color(1, 1, 1), 1)
extends ColorRect

var enabled = false

var timertime = 0
var timerstep = 8

var shadertime = 0.0

func _physics_process(delta):
	if enabled:
		timertime += 1
		if timertime % timerstep == 0:
			shadertime += delta
			material.set_shader_param("mytime", shadertime)
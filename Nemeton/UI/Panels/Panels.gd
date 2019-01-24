extends VBoxContainer

func _ready():
	
	for i in $V.get_children():
		i.visible = false
		i.modulate = Color(1, 1, 1, 0)
	for i in $H.get_children():
		i.disabled = true
	
	$V/Menu.visible = true
	$V/Menu.modulate = Color(1, 1, 1, 1)
	
	$H/Menu.modulate = Color(1, 1, 1, 1)
	$H/Menu.disabled = true
	$H/Options.modulate = Color(1, 1, 1, 1)
	$H/Options.disabled = false


func _on_TabButton_pressed(id):
	
	# Panels
	for i in $V.get_children():
		
		var target = $V.get_child(id)
		
		if not i == target:
			i.modulate = Color(1, 1, 1, 0)
			i.visible = false
		
		target.modulate = Color(1, 1, 1, 1)
		target.visible = true
	
	# Buttons
	for i in $H.get_children():
		i.disabled = false
	
	$H.get_child(id).disabled = true
extends PanelContainer

var action = null


func _ready():
	$VBoxContainer/C2/H.visible = false


func _on_NewGame_pressed():
	request_confirmation(0)


func _on_QuitGame_pressed():
	request_confirmation(1)


func request_confirmation(type):
	if type == 0:
		$VBoxContainer/C2/H/Label.text = "New Game?"
		$VBoxContainer/C2/H.visible = true
		action = 0
	elif type == 1:
		$VBoxContainer/C2/H/Label.text = "Quit Game?"
		$VBoxContainer/C2/H.visible = true
		action = 1


func _on_Confirm_pressed():
	$VBoxContainer/C2/H.visible = false
	if action == 0:
		Game.start_new_game()
	elif action == 1:
		Game.quit_game()
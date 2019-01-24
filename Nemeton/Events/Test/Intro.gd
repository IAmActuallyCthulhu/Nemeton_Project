extends "res://Events/Event.gd"

func start():
	text("Hello world!")
	new_paragraph()
	text("Player Name: " + Party.leader.name_full)
	event_button(0, "Next", "res://Events/Test/Page2.gd")
	exit_button(7, "Exit Event")
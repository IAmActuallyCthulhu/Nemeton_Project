extends Node

onready var ER = get_tree().get_nodes_in_group("Event_Reader")[0]

	# Append text.
func text(text):
	ER.append_line(text)

	# Assure new line before next text.
func new_line():
	ER.assure_new_line()

	# Assure new paragraph before next text.
func new_paragraph():
	ER.assure_new_paragraph()

	# Button that goes to another event.
func event_button(button_id, label, target_event):
	ER.set_button(button_id, label, "event", target_event)

	# Button that exits the event and returns to the map.
func exit_button(button_id, label):
	ER.set_button(button_id, label, "exit")
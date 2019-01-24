extends Node

	# Notification Singleton

var UI = UINotifier.new(self)
var STATE = StateNotifier.new(self)

class UINotifier:
	extends Node
	
	enum {
		TITLESCREEN,
		NEW_GAME,
		PARTY_MEMBERS_CHANGED,
		CHAR_NAME_CHANGED,
	}
	
	func _init(parent):
		parent.add_child(self)
	
	func subscribe(node_to_connect):
		node_to_connect.add_to_group("UI_notification")
	
	func unsubscribe(node_to_disconnect):
		node_to_disconnect.remove_from_group("UI_notification")
	
	func notify(message = -1, sender = -1, data = -1):
		if message == -1:
			print("Warning: UI notification without message.")
			return
		get_tree().call_group("UI_notification", "_UI_notification", message, sender, data)


class StateNotifier:
	extends Node
	
	enum {
		TITLESCREEN_ENTERED,
		NEW_GAME_STARTED,
		START_EVENT, # Passes file path
		EVENT_FINISHED,
		FIGHT_STARTED, # Passes file path
		FIGHT_FINISHED,
	}
	
	func _init(parent):
		parent.add_child(self)

	func subscribe(node_to_connect):
		node_to_connect.add_to_group("STATE_notification")
	
	func unsubscribe(node_to_disconnect):
		node_to_disconnect.remove_from_group("STATE_notification")

	func notify(message, data = -1):
		if message == -1:
			print("Warning: STATE notification without message.")
			return
		get_tree().call_group("STATE_notification", "_STATE_notification", message, data)
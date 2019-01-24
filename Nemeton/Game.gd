extends Node

	# Game State Management Singleton
	# Has an action queue for sequental event/fight processing.

var queue = Action_Queue.new(self)


func _init():
	Notice.STATE.subscribe(self)


	# Game Boot
func _ready():
	goto_titlescreen()


func _STATE_notification(message, data):
	match message:
		
		Notice.STATE.NEW_GAME_STARTED:
			queue.next()
		
		Notice.STATE.EVENT_FINISHED:
			queue.next()


func goto_titlescreen():
	Notice.UI.notify(Notice.UI.TITLESCREEN)
	Notice.STATE.notify(Notice.STATE.TITLESCREEN_ENTERED)


func start_new_game():
	Party.reset_all()
	queue.reset()
	queue.add_event("res://Events/Test/Intro.gd")
	Notice.UI.notify(Notice.UI.NEW_GAME)
	Notice.STATE.notify(Notice.STATE.NEW_GAME_STARTED)


func quit_game():
	get_tree().quit()


func start_event(file_path):
	Notice.STATE.notify(Notice.STATE.START_EVENT, file_path)


func start_fight(file_path):
	pass


func goto_map():
	pass


class Action_Queue:
	extends Node
	
	onready var FileChecker = File.new()
	var queue = []
	
	func _init(parent):
		parent.add_child(self)
	
	func reset():
		queue = []
	
	func next():
		if queue.size() == 0:
			Game.goto_map()
		
		else:
			var next = queue[0]
			queue.pop_front()
			
			match next[0]:
				
				"event":
					Game.start_event(next[1])
				
				"fight":
					Game.start_fight(next[1])
	
	
	func add_event(event_path, prepend = false, allow_duplicate = false):
		if not FileChecker.file_exists(event_path):
			print("ERROR: Invalid event path to append to queue.")
			return
		
		if not allow_duplicate:
			for i in queue:
				if i[1] == event_path:
					return
		
		if prepend:
			queue.push_front(["event", event_path])
		else:
			queue.push_back(["event", event_path])
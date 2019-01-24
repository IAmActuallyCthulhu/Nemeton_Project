extends PanelContainer

onready var BUTTONS = [
		$"V/Buttons/0", $"V/Buttons/1", $"V/Buttons/2", $"V/Buttons/3", 
		$"V/Buttons/4", $"V/Buttons/5", $"V/Buttons/6", $"V/Buttons/7"
		]
var BUTTON_DATA = [null, null, null, null, null, null, null, null]

var active_event = null

func _init():
	Notice.UI.subscribe(self)
	Notice.STATE.subscribe(self)

func _ready():
	for i in range(BUTTONS.size()):
		BUTTONS[i].connect("pressed", self, "on_button_pressed", [i])


func _UI_notification(message, sender, data):
	match message:
		
		Notice.UI.TITLESCREEN:
			visible = false


func _STATE_notification(message, data):
	match message:
		
		Notice.STATE.START_EVENT:
			load_event(data)
			visible = true


func load_event(path):
	clear_event()
	
	if path.is_abs_path():
		active_event = load(path).new()
		add_child(active_event)
	
		if active_event.has_method("start"):
			active_event.start()
		else:
			print("ERROR: EREADER: Missing event start.")


func clear_event():
	if active_event:
		active_event.queue_free()
	
	$V/Text.clear()
	
	for i in range(BUTTONS.size()):
		clear_button(i)


func on_button_pressed(button_id):
	var data = BUTTON_DATA[button_id]
	
	match data.type:
		
		"event":
			load_event(data.args)
		
		"exit":
			Notice.STATE.notify(Notice.STATE.EVENT_FINISHED)
			visible = false


func append_line(text):
	$V/Text.append_bbcode(text)


func assure_new_line():
	$V/Text.newline()

func assure_new_paragraph():
	$V/Text.newparagraph()


func set_button(button_id, label, type, args = false):
	clear_button(button_id)
	
	BUTTONS[button_id].text = label
	# TODO: ICON based on type
	BUTTON_DATA[button_id] = {"label" : label, "type" : type, "args" : args}
	BUTTONS[button_id].disabled = false


func clear_button(button_id):
	BUTTON_DATA[button_id] = null
	BUTTONS[button_id].text = ""
	BUTTONS[button_id].disabled = true
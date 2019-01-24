extends Node

	# Character Base Class
signal character_data_changed

var default_data = null
var data = {
		
		#Display Names
		"name_first" : "Unnamed",
		"name_last" : "Character",
		"name_full" : "Unnamed Character",
		"name_nick" : "Char",
		
			#Health
		"health_min" : 0,
		"health_cur" : 100,
		"health_max" : 100,
		
			#Stress
		"stress_min" : 0,
		"stress_cur" : 100,
		"stress_max" : 100,
		
			#Attributes
		"attr_min" : 1,
		"attr_max" : 6,
		"attr_def" : 1,
		
		"strength_cur" : 1,
		"agility_cur" : 1,
		"insight_cur" : 1,
		"willpower_cur" : 1,
		
		}


	# Constructor. Called by Party.gd. Merges defaults and char specific dicts.
func _init(default_data):
	default_data = load(default_data).new().data
	for i in default_data:
		data[i] = default_data[i]

func _reset():
	if not default_data:
		return
	
	for i in default_data:
		data[i] = default_data[i]

	# Code Helpers. Allows for nicer dictionary access.
var ID setget set_ID, get_ID
var name_first setget set_name_first, get_name_first
var name_last setget set_name_last, get_name_last
var name_full setget set_name_full, get_name_full

func set_ID(new_ID):
	print("WARNING: Character ID is not changable.")

func get_ID():
	return data.ID

func set_name_first(new_name):
	data.name_first = new_name
	data.name_full = data.name_first + " " + data.name_last
	Notice.UI.notify(Notice.UI.CHAR_NAME_CHANGED, data.ID, new_name)

func get_name_first():
	return data.name_first

func set_name_last(new_name):
	data.name_last = new_name
	data.name_full = data.name_first + " " + data.name_last
	Notice.UI.notify(Notice.UI.CHAR_NAME_CHANGED, data.ID, new_name)

func get_name_last():
	return data.name_last

func set_name_full(new_name):
	print("WARNING: You must set first and last names seperately.")

func get_name_full():
	return data.name_full
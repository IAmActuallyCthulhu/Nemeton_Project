extends Node

	# Party management singleton.
	# Objects should be subscribed in '_init'.


	# Load characters here.
onready var Player = preload("res://Characters/Character.gd").new("res://Characters/Player/Player.gd")


	# Configure characters.
func reset_all():
	party[1] = false
	party[2] = false
	for i in CHARACTERS:
		CHARACTERS[i]._reset()


	# Coding helpers.
var leader setget ,get_leader
var follower_1 setget ,get_follower_1
var follower_2 setget ,get_follower_2
var random setget ,get_random
var random_follower setget ,get_random_follower


	# VARIABLES
onready var party = [Player, false, false]
onready var CHARACTERS = {
		Player.ID : Player,
		}


	# SETGET
func get_leader():
	if party[0] != null:
		return party[0]
	else:
		return -1

func get_follower_1():
	if party[1] != null:
		return party[1]
	else:
		return -1

func get_follower_2():
	if party[2] != null:
		return party[2]
	else:
		return -1

func get_random():
	var e = []
	for i in party:
		if i != null:
			e.append(i)
	return e[randi() % e.size()]

func get_random_follower():
	var e = []
	for i in party:
		if i != null:
			e.append(i)
	if e[0] == party[0]:
		e.pop_front()
	return e[randi() % e.size()]


	# PUBLIC
func add_member(character_name):
	var slot_id = can_add_follower()
	var character_class = get_character_class(character_name)
	if not slot_id == -1 and not character_class == -1:
		party[slot_id] = character_class
	Notice.UI.notify(Notice.UI.PARTY_MEMBERS_CHANGED)

func remove_member(character_name):
	var slot_id = null
	var character_class = get_character_class(character_name)
	if not character_class == -1:
		slot_id = party.find(character_class)
	if not slot_id == -1:
		party[slot_id] = null
	Notice.UI.notify(Notice.UI.PARTY_MEMBERS_CHANGED)


	# PRIVATE
func can_add_follower():
	if party[1] == null:
		return 1
	elif party[2] == null:
		return 2
	else:
		return -1

func get_character_class(character_name):
	if CHARACTERS.keys().has(character_name):
		return CHARACTERS[character_name]
	else:
		return -1

func get_party_size():
	var count = 0
	for i in party:
		if i != null:
			count += 1
	return count
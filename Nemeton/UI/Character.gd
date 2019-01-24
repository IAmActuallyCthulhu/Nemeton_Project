extends PanelContainer

signal character_changed

export(int, "Player", "Follower 1", "Follower 2") var ID = 0
var character

func _init():
	Notice.UI.subscribe(self)

func _UI_notification(message, sender, data):
	match message:
		
		Notice.UI.TITLESCREEN:
			visible = false
		
		Notice.UI.NEW_GAME:
			visible = false
		
		Notice.UI.PARTY_MEMBERS_CHANGED:
			if Party.party[ID]:
				visible = true
				character = Party.party[ID]
				emit_signal("character_changed")
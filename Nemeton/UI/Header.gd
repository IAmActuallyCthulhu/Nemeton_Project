extends PanelContainer

func _init():
	Notice.UI.subscribe(self)

func _UI_notification(message, sender, what):
	match message:
		
		Notice.UI.TITLESCREEN:
			visible = false
		
		Notice.UI.NEW_GAME:
			visible = true
extends PanelContainer

var INI = ConfigFile.new()

var THEME = preload("res://Theme/Default.theme")

const DEF_TEXT_SIZE = 24
const DEF_TEXT_COLOR = Color8(192, 188, 167)
const DEF_BACKGROUND_COLOR = Color8(5, 5, 5)


func _ready():
	load_settings()


func load_settings():
	INI.load("config.ini")
	
	# Font size
	var font_size = INI.get_value("text", "size", DEF_TEXT_SIZE)
	var rtl_fonts = THEME.get_font_list("RichTextLabel")
	for i in rtl_fonts:
		var font = THEME.get_font(i, "RichTextLabel")
		font.size = font_size
		font.update_changes()
	$S/V/Text_Options/Text_Size/SpinBox.value = font_size

	# Font color
	var font_color = INI.get_value("text", "color", DEF_TEXT_COLOR)
	THEME.set_color("default_color", "RichTextLabel", font_color)
	$S/V/Text_Options/Text_Color/ColorPickerButton.color = font_color

	# Background color
	var background_color = INI.get_value("text", "background_color", DEF_BACKGROUND_COLOR)
	var stylebox = THEME.get_stylebox("normal", "RichTextLabel")
	#stylebox.modulate_color = background_color
	stylebox.bg_color = background_color
	THEME.set_stylebox("normal", "RichTextLabel", stylebox)
	$S/V/Text_Options/Background_Color/ColorPickerButton.color = background_color


func _on_Apply_pressed():
	INI.set_value("text", "size", $S/V/Text_Options/Text_Size/SpinBox.value)
	INI.set_value("text", "color", $S/V/Text_Options/Text_Color/ColorPickerButton.color)
	INI.set_value("text", "background_color", $S/V/Text_Options/Background_Color/ColorPickerButton.color)
	INI.save("config.ini")
	load_settings()


func _on_Discard_pressed():
	INI.set_value("text", "size", DEF_TEXT_SIZE)
	INI.set_value("text", "color", DEF_TEXT_COLOR)
	INI.set_value("text", "background_color", DEF_BACKGROUND_COLOR)
	INI.save("config.ini")
	load_settings()
extends RichTextLabel

	# Purpose:
	# Keep an external stack of appended and parsed bbcode.
	# When node is redrawn, and text defaults to bbcode property...
	# feed it the correct text from the history.

var bbcode_stack = PoolStringArray()


func _notification(what):
	if what == Control.NOTIFICATION_THEME_CHANGED:
		reload_bbcode_text()
	elif what == CanvasItem.NOTIFICATION_DRAW:
		reload_bbcode_text()
	#._notification(what)


func reload_bbcode_text():
	bbcode_text = ""
	for i in bbcode_stack:
		bbcode_text += i


func append_bbcode(text_bbcode = null):
	bbcode_stack.append(text_bbcode)
	return .append_bbcode(text_bbcode)


func parse_bbcode(bbcode = null):
	clear()
	bbcode_stack.append(bbcode)
	return .parse_bbcode(bbcode)


func clear():
	bbcode_stack = PoolStringArray()
	return .clear()


func newline():
	if not bbcode_stack[-1].ends_with("\n"):
		bbcode_stack.append("\n")


func newparagraph():
	if not bbcode_stack[-1].ends_with("\n\n"):
		if bbcode_stack[-1].ends_with("\n"):
			append_bbcode("\n")
		else:
			append_bbcode("\n\n")


	# Voided Functions
	# These are intentionally inert to prevent accidental contamination...
	# of the bbcode_stack. always use append_bbcode or parse_bbcode.
func add_image(texture = null):
	print("BRTL: add_image is void")
	return

func add_text(text_raw = null):
	print("BRTL: add_text is void")
	return

func push_align(align = null):
	print("BRTL: push_align is void")
	return

func push_cell():
	print("BRTL: push_cell is void")
	return

func push_color(color = null):
	print("BRTL: push_color is void")
	return

func push_font(font = null):
	print("BRTL: push_font is void")
	return

func push_indent(level = null):
	print("BRTL: push_indent is void")
	return

func push_list(type = null):
	print("BRTL: push_list is void")
	return

func push_meta(data = null):
	print("BRTL: push_meta is void")
	return

func push_table(columns = null):
	print("BRTL: push_table is void")
	return

func push_underline():
	print("BRTL: push_underline is void")
	return
extends RichTextLabel


func set_credits(c):
	bbcode_text = "[center]Credits:[/center][center][shake rate=5 level=10]" + str(c) + "[/shake][/center]"

func set_score(c, d):
	if d == INF:
		bbcode_text = "[center][/center][center][shake rate=5 level=10]finish the song[/shake][/center]"
	else:
		bbcode_text = "[center]Score:[/center][center][shake rate=5 level=10]" + str(c) + "/" + str(d) + "[/shake][/center]"

extends Node

var record = 0
var l1_record = 0
var l2_record = 0
var l3_record = 0

func _ready():
	load_game()

func save():
	var save_dict = {
		"l1_record": l1_record,
		"l2_record": l2_record,
		"l3_record": l3_record
	}
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	save_game.open("user://savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		if current_line is Dictionary:
			if current_line.has("l1_record"):
				record = current_line["l1_record"]
			if current_line.has("l2_record"):
				record = current_line["l2_record"]
			if current_line.has("l3_record"):
				record = current_line["l3_record"]
	save_game.close()
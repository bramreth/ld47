extends Node

var record = 0
var l1_record = 0
var l2_record = 0
var l3_record = 0
var auto = false
var r = 0
var s = 0

var credits = 0

var credit_list = [
	10,
	25,
	50,
	75,
	100,
	200,
	300,
	400,
	500,
	600,
	INF
]

var creds_obj = {
	"lv1": 0,
	"lv2": 0,
	"lv3": 0
}

func get_credit(cur_lv):
	return credit_list[creds_obj[cur_lv]]

func check_credit(k, cur_lv):
	if k >= credit_list[creds_obj[cur_lv]]:
		credits += 1
		creds_obj[cur_lv] += 1
		return true
	else:
		return false
		


func _ready():
	load_game()

func save():
	var save_dict = {
		"l1_record": l1_record,
		"l2_record": l2_record,
		"l3_record": l3_record,
		"obj1": creds_obj["lv1"],
		"obj2": creds_obj["lv2"],
		"obj3": creds_obj["lv3"],
		"auto": auto,
		"credits": credits,
		"r": r,
		"s": s,
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
				l1_record = current_line["l1_record"]
			if current_line.has("l2_record"):
				l2_record = current_line["l2_record"]
			if current_line.has("l3_record"):
				l3_record = current_line["l3_record"]
			if current_line.has("auto"):
				auto = current_line["auto"]
			if current_line.has("r"):
				r = current_line["r"]
			if current_line.has("s"):
				s = current_line["s"]
			if current_line.has("credits"):
				credits = current_line["credits"]
			if current_line.has("obj1"):
				creds_obj["lv1"] = current_line["obj1"]
			if current_line.has("obj2"):
				creds_obj["lv2"] = current_line["obj2"]
			if current_line.has("obj3"):
				creds_obj["lv3"] = current_line["obj3"]
	save_game.close()

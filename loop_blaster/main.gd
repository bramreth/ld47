extends Node2D


var kills = 0
var health = 1
var money = 50

var s1 = preload("res://insayne.wav")
var s2 = preload("res://insayne2.wav")
var s3 = preload("res://tensse.wav")

var started = false

var weapon_normal = {
	'shoot_speed': 0.5,
	'bullet': preload("res://bullet.tscn"),
	'shots': 1,
	'spread': 0,
	'pitch': 3.0,
	'reload_upgrade': Manager.r,
	'bullet_upgrade': Manager.s
}

var weapon_shotty = {
	'shoot_speed': 0.3,
	'bullet': preload("res://shottybullet.tscn"),
	'shots': 6,
	'spread': 0.5,
	'pitch': 0.5,
	'reload_upgrade': Manager.r,
	'bullet_upgrade': Manager.s
}

var levels = {
	"lv1": {
		"sound": s2,
		"color": "54a0ff",
		"weak_color": "ff9ff3",
		"speed": 4.0,
		"segs": 12,
		'weapons': [weapon_normal]
	},
	"lv2": {
		"sound": s3,
		"color": "5f27cd",
		"weak_color": "48dbfb",
		"speed": 3.0,
		"segs": 16,
		'weapons': [weapon_normal]
	},
	"lv3": {
		"sound": s1,
		"color": "feca57",
		"weak_color": "ff6b6b",
		"speed": 2.0,
		"segs": 20,
		'weapons': [weapon_normal, weapon_shotty]
	}
}
var cur_lv = ""

func damage_player():
	if not $Player: return
	health -= 1
	$bg/Label.text = str(health)
	if health <= 0:
		game_over()
		
func game_over():
	if $Player:
		$Player.queue_free()
		$AudioStreamDeath.play()
		$AudioStreamDeath2.play()
		$death_anim/Particles2D.restart()
		match cur_lv:
			"lv1":
				if kills > Manager.l1_record:
					Manager.l1_record = kills
					Manager.save()
			"lv2":
				if kills > Manager.l2_record:
					Manager.l2_record = kills
					Manager.save()
			"lv3":
				if kills > Manager.l3_record:
					Manager.l3_record = kills
					Manager.save()
		update_records()
		$transition/AnimationPlayer.play("fade_out")
		
func update_records():
	for item in get_tree().get_nodes_in_group("option"):
		item.update_record()

# Called when the node enters the scene tree for the first time.
func _ready():
	update_records()
	$loop_spawner.connect("wave_started", $wave_label, 'show_wave')
	$Player.weapons = [weapon_normal, weapon_shotty]
	$Player.current_weapon = 0
	$Player.set_weapon()
	$UI/Panel/VBoxContainer/record.text = str(Manager.record)
#	setup_level("l3")
	$bg/Label.text = str(health)
	$bg/Label.text = str(health)
	$transition/AnimationPlayer.play("fade_in")
	$level_select/AnimationPlayer.play("start")
	
	
func setup_level(type):
	print(levels[type])
	$wave_label.col = levels[type]["color"]
	$AudioStreamPlayer.stream = levels[type]["sound"]
	$AudioStreamPlayer.play()
	$loop_spawner.segs = levels[type]["segs"]
	$loop_spawner/loop_collision.set_segs(levels[type]["segs"])
	$loop_spawner.col1 = levels[type]["color"]
	$loop_spawner.col2 = levels[type]["weak_color"]
	$loop_spawner.speed = levels[type]["speed"]
	$Player.set_col(levels[type]["weak_color"])
	$Player.weapons = levels[type]["weapons"]
	$Player.current_weapon = 0
	$Player.set_weapon()
	$loop_spawner.load_waves()
	$loop_spawner.start_wave()
	$loop_spawner/Timer.start()
	cur_lv = type

func add_kill():
	kills += 1
	$UI/Panel/VBoxContainer/count.text = str(kills)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func dud(gpos):
	$particle_pool/miss.global_position = gpos
	$particle_pool/miss.restart()
	
func hit(gpos):
	$particle_pool/hit.global_position = gpos
	$particle_pool/hit.restart()

func start_round():
	pass
	# stuff to do with starting the main menu

func reset():
	print("reset")
	get_tree().reload_current_scene()

func _on_Button_pressed():
	$transition/AnimationPlayer.play("fade_out")


func _on_Button2_pressed():
	get_tree().quit()
	
func handle_option(area_in):
	if started: return
	print(area_in.name, "!")
	var levels = ["option", "option2", "option3"]
	
	if levels.find(area_in.name) != -1:
		area_in.die()
		setup_level(area_in.levels[area_in.option_type][0])
		$AudioStreamSelect.play()
		started = true
		var other_items = get_tree().get_nodes_in_group("option")
		other_items.remove(other_items.find(area_in))
		for item in other_items:
			yield(get_tree().create_timer(0.2), "timeout")
			if item:
				item.die()
	else: 
		area_in.die_but_not_really()
		var upgrade_amount = upgrade(area_in.upgrade_type)
		if upgrade_amount:
			$UI.change_money(money)
			area_in.update_rec(upgrade_amount)
	

func upgrade(type):
	if type =="reload" and Manager.r < 5 and money >= Manager.r + 1:
		Manager.r += 1
		money -= Manager.r
		Manager.save()
		return Manager.r
	elif type == "bullet" and Manager.s < 5 and money >= Manager.s + 1:
		Manager.s += 1
		money -=  Manager.s
		Manager.save()
		return  Manager.s
	elif type == "auto" and money >= 10:
		money -= 10
		Manager.auto = true
		Manager.save()
		return true
	
	return 0

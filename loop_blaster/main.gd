extends Node2D


var kills = 0
var health = 1

var s1 = preload("res://insayne.wav")
var s2 = preload("res://insayne2.wav")
var s3 = preload("res://tensse.wav")

var started = false

var levels = {
	"lv1": {
		"sound": s2,
		"color": "54a0ff",
		"weak_color": "ff9ff3",
		"speed": 4.0,
		"segs": 12
	},
	"lv2": {
		"sound": s3,
		"color": "5f27cd",
		"weak_color": "48dbfb",
		"speed": 3.0,
		"segs": 16
	},
	"lv3": {
		"sound": s1,
		"color": "feca57",
		"weak_color": "ff6b6b",
		"speed": 2.0,
		"segs": 20
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
		$UI/retry_box/AnimationPlayer.play("retry")
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
		
func update_records():
	for item in get_tree().get_nodes_in_group("option"):
		item.update_record()

# Called when the node enters the scene tree for the first time.
func _ready():
	update_records()
#	setup_level("l3")
	$bg/Label.text = str(health)
	$bg/Label.text = str(health)
	$transition/AnimationPlayer.play("fade_in")
	$level_select/AnimationPlayer.play("start")
	
	
func setup_level(type):
	print(levels[type])
	$AudioStreamPlayer.stream = levels[type]["sound"]
	$AudioStreamPlayer.play()
	$loop_spawner.segs = levels[type]["segs"]
	$loop_spawner/loop_collision.set_segs(levels[type]["segs"])
	$loop_spawner.col1 = levels[type]["color"]
	$loop_spawner.col2 = levels[type]["weak_color"]
	$loop_spawner.speed = levels[type]["speed"]
	$Player.set_col(levels[type]["weak_color"])
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
	setup_level(area_in.levels[area_in.option_type][0])
	area_in.die()
	$AudioStreamSelect.play()
	started = true
	for item in get_tree().get_nodes_in_group("option"):
		yield(get_tree().create_timer(0.2), "timeout")
		if item:
			item.die()
	

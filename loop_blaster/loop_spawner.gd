extends Node2D

var loops = []
var loop = preload("res://loop.tscn")
export(int) var segs

var col1 = null
var col2 = null

var speed = null

var easy_waves = [
	{
		"weak": 12,
		"pattern": [
			4, 0.8
		],
		"pause": 3.0
	},
	{
		"weak": 10,
		"pattern": [
			8, 1
		],
		"pause": 3.0
	},
]

var med_waves = [
	{
		"weak": 8,
		"pattern": [
			6, 0.7
		],
		"pause": 2.0
	},
	{
		"weak": 6,
		"pattern": [
			8, 0.6
		],
		"pause": 2.0
	},
]

var hard_waves = [
	{
		"weak": 2,
		"pattern": [
			10, 0.6
		],
		"pause": 1.0
	},
	{
		"weak": 4,
		"pattern": [
			12, 0.5
		],
		"pause": 1.0
	},
]

var waves = []
var current_wave = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	

func spawn(weak):
	var l = loop.instance()
	l.speed = speed
	l.set_cols(col1, col2)
	l.weak_segments = weak
	l.segments = segs
	add_child(l)
	l.connect("dead", self, "replace_loop")
	if loops.empty():
		$loop_collision.active_loop(l)
	loops.push_back(l)
	l.start()
	

func replace_loop(lp, shot):
	if shot: 
		get_parent().add_kill()
		$AudioStreamPlayer.pitch_scale = 1.0 + randf()/5 - 0.1
		$AudioStreamPlayer.play()
	else: 
		get_parent().damage_player()
	loops.remove(loops.find(lp))
	if loops:
		$loop_collision.active_loop(loops[0])
	
var counter = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if waves.empty() and current_wave.empty():
		if counter > 8:
			waves.push_back(hard_waves[randi()%len(hard_waves)])
		elif counter > 4:
			waves.push_back(med_waves[randi()%len(med_waves)])
		else:
			waves.push_back(easy_waves[randi()%len(easy_waves)])
		counter += 1
		print(counter)
		start_wave()

func start_wave():
	var w = waves.pop_front()
	for i in w["pattern"][0]:
		current_wave.append([w["weak"], w["pattern"][1]])
	current_wave.append(w["pause"])
	print(current_wave)


func _on_Timer_timeout():
	if not current_wave.empty():
		var w = current_wave.pop_front()
		if w is Array:
			$Timer.wait_time = w[1]
			spawn(w[0])
			
			if len(current_wave) <= 1:
				w = current_wave.pop_front()
				$Timer.wait_time = w

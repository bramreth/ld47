extends Node2D

var loops = []
var loop = preload("res://loop.tscn")
export(int) var segs

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$loop_collision.set_segs(segs)
	if loops.empty():
		spawn()

func spawn():
	var l = loop.instance()
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
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if loops.empty():
#		spawn()


func _on_Timer_timeout():
	spawn()

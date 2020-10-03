extends Node2D


export(int) var max_width = 75
export(int) var segments = 16
export(int) var weak_segments = 4
signal dead(this)

func get_segs():
#	var weak_segs = []
#	for p in len($Line2D/WeakSpot.points) - 1:
#		weak_segs.append({[$Line2D/WeakSpot.points[p], $Line2D/WeakSpot.points[p]+1]: true})
#	return weak_segs
	var segs = {}
	for p in range(len($Line2D.points)-1):
		segs[[$Line2D.points[p], $Line2D.points[p+1 % len($Line2D.points)]]] = false
#	for p in range(len($Line2D/WeakSpot.points)-1):
#		segs[[$Line2D/WeakSpot.points[p], $Line2D/WeakSpot.points[p+1]]] = true
	for k in segs.keys():
		if k[0] in $Line2D/WeakSpot.points and k[1] in $Line2D/WeakSpot.points:
			segs[k] = true
	return segs
		
func dud():
	$AudioStreamPlayer.play()
# Called when the node enters the scene tree for the first time.
func _ready():
	create_loop()

func create_loop():
	$Line2D.add_point(Vector2(cos(0), sin(0)))
	for seg in range(segments):
		var p = deg2rad((float(seg+1) / segments) * 360.0)
		$Line2D.add_point(Vector2(cos(p), sin(p)))
	$Line2D.init(weak_segments)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func start():
	$CurveTween.play(3)

func _on_Button_pressed():
	start()


func _on_CurveTween_curve_tween(sat):
	$Line2D.distance = max_width * sat

func die(shot):
	emit_signal("dead", self, shot)
	queue_free()

func _on_CurveTween_tween_all_completed():
	die(false)

extends Node2D


export(int) var max_width = 75
export(int) var segments = 16
export(int) var weak_segments = 4


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


func _on_Button_pressed():
	$CurveTween.play(3)


func _on_CurveTween_curve_tween(sat):
	$Line2D.distance = max_width * sat


func _on_CurveTween_tween_all_completed():
	queue_free()

extends Node2D

signal reload_done()

func _ready():
	$Tween.connect("tween_all_completed", self, "reload_done")

func reload_done():
	emit_signal('reload_done')

func reload(time:float):
	$Tween.interpolate_property(
		$left,
		"rotation_degrees",
		-70,
		0,
		time,
		Tween.TRANS_EXPO,
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		$right,
		"rotation_degrees",
		70,
		0,
		time,
		Tween.TRANS_EXPO,
		Tween.EASE_OUT
	)
	$Tween.start()

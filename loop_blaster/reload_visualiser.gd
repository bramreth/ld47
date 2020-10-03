extends Node2D

signal reload_done()

func _ready():
	$Tween.connect("tween_all_completed", self, "reload_done")

func reload_done():
	$left.hide()
	$right.hide()
	emit_signal('reload_done')

func reload(time:float):
	$Tween.stop_all()
	$left.show()
	$right.show()
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
		$left,
		"width",
		15,
		5,
		time,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		$left,
		"default_color",
		Color("576574"),
		Color("ee5253"),
		time,
		Tween.TRANS_LINEAR,
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
	$Tween.interpolate_property(
		$right,
		"width",
		15,
		5,
		time,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		$right,
		"default_color",
		Color("576574"),
		Color("ee5253"),
		time,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	$Tween.start()

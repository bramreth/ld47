extends Node2D

signal reload_done()

var current_bullet_color:Color = Color("ee5253")
var reload_color := Color("576574")

func _ready():
	$Tween.connect("tween_all_completed", self, "reload_done")

func reload_done():
	$left.hide()
	$right.hide()
	$fire.show()
	emit_signal('reload_done')

func reload(time:float):
	$Tween.stop_all()
	$left.show()
	$right.show()
	$fire.hide()
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
		reload_color,
		current_bullet_color,
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
		reload_color,
		current_bullet_color,
		time,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	$Tween.start()

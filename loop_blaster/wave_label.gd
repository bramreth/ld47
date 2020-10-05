extends Control

var col:Color = Color.white

func _ready(): 
	$Label.modulate = Color("00FFFFFF")

func show_wave(wave_num):
	$Label.text = "WAVE " + String(wave_num)
	$Label.modulate = col
	$Tween.stop_all()
	$Tween.interpolate_property($Label, 'modulate', col, Color("00FFFFFF"), 2.0, Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()

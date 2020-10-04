extends Node2D


var kills = 0
var health = 1

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
# Called when the node enters the scene tree for the first time.
func _ready():
	$bg/Label.text = str(health)
	$bg/Label.text = str(health)
	$transition/AnimationPlayer.play("fade_in")

func add_kill():
	kills += 1
	$UI/Panel/VBoxContainer/count.text = str(kills)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func start_round():
	$loop_spawner/Timer.start()

func reset():
	print("reset")
	get_tree().reload_current_scene()

func _on_Button_pressed():
	$transition/AnimationPlayer.play("fade_out")


func _on_Button2_pressed():
	get_tree().quit()

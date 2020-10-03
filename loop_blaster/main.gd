extends Node2D


var kills = 0
var health = 3

func damage_player():
	if not $Player: return
	health -= 1
	$bg/Label.text = str(health)
	if health <= 0:
		game_over()
		
func game_over():
	if $Player:
		$Player.queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	$bg/Label.text = str(health)

func add_kill():
	kills += 1
	$UI/Panel/VBoxContainer/count.text = str(kills)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

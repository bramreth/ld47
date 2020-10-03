extends Area2D

export(bool) var weak = false

func get_weak():
	return weak

func update_shape(v1, v2):
	$CollisionShape2D.shape.a = v1
	$CollisionShape2D.shape.b = v2

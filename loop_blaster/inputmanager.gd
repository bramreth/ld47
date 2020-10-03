extends Node

signal update_control_preference(control_preference)

enum CONTROL_TYPE {
	MOUSE,
	KEYBOARD
}

var control_preference:int = CONTROL_TYPE.MOUSE


func change_control_type(new_preference:int):
	control_preference = new_preference
	emit_signal("update_control_preference", control_preference)

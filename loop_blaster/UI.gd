extends Control




func change_input_method():
	match(inputmanager.control_preference):
		inputmanager.CONTROL_TYPE.KEYBOARD: inputmanager.change_control_type(inputmanager.CONTROL_TYPE.MOUSE)
		inputmanager.CONTROL_TYPE.MOUSE: inputmanager.change_control_type(inputmanager.CONTROL_TYPE.KEYBOARD)


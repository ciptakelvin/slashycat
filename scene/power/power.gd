extends HSlider

var INCREAMENT = 150
var DECREAMENT = 200
var power_value:float = 0
var is_active = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		increase_power()
	
	if is_active:
		power_value -= DECREAMENT * delta
	
	if value == 0:
		is_active = false
	
	value = power_value


func increase_power():
	if not is_active:
		power_value += INCREAMENT

	if value >= max_value:
		is_active = true

	print(max_value,value)

extends Node

@onready var day_screen = $DayScreen
@onready var day_label = day_screen.get_node("DayLabel")

# Call this function from your Yarn nodes
func show_day_screen(day_number):
	var day_num = int(day_number)  # ensure it's an integer
	day_label.text = "Day %d" % day_num
	day_screen.visible = true
	
	# Wait 2 seconds
	await get_tree().create_timer(2.0).timeout
	
	# Hide the screen after 2 seconds
	day_screen.visible = false

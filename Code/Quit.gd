extends Button



func _on_Quit_button_up():
	
	get_tree().quit()


func _on_Quit_button_down():
	$button_press.play()

extends Button



func _on_Retry_button_up():
	
	PlayerData.score = 0
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Retry_button_down():
	$button_press.play()

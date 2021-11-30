extends Button

func _on_Button_button_up():
	get_tree().paused = false
	get_tree().change_scene("res://Title_Scene.tscn")


func _on_Button_button_down():
	$button_press.play()

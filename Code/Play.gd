extends Button


func _on_Play_button_up():
	
	get_tree().change_scene("res://MainScene.tscn")
	







func _on_Play_button_down():
	$button_press.play()

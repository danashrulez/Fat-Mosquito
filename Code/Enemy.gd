extends Area2D

export var speed : int = 800
export var moveDist : int = 200


onready var startY : int = position.y
onready var targetY : int = position.y + moveDist


func _process(delta):
	
	position.y = moveTo(position.y, targetY, speed*delta)
	
	if position.y == targetY:
		if targetY == startY:
			targetY = position.y + moveDist
			yield(get_tree().create_timer(0.5), "timeout")
			queue_free()
		else:
			targetY = startY - 300


func moveTo(current, to, step):
	
	var new = current
	if new < to:
		new += step
		if new >to:
			new = to
	else:
		new -=step
		if new<to:
			new = to
	
	return new
	


func _on_Enemy_body_entered(body):
	if body.name =="Player":
		body.die()

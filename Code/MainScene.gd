extends Node2D

var enemy = preload("res://EnemyScene.tscn")


	
func _process(delta):
	if $bgm.playing == false:
		$bgm.play()
	
func instance_node(node,location,parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
	
func _on_Enemy_Spawn_Timer_timeout():
	var enemy_position = Vector2($Player.position.x, -300)
	
	instance_node(enemy,enemy_position,self)


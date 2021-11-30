extends Control

onready var scoreText = get_node("Score")
onready var scene_tree: = get_tree()
onready var pause_overlay: = get_node("PauseOverlay")
var paused: = false setget set_paused

func _ready():
	scoreText.text = "0"
	#PlayerData.connect("score_updated", self, "updated_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	
	
func _on_PlayerData_player_died():
	self.paused = true
	
func set_score (score):
	scoreText.text = str(score)+" ml"

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Pause"):
		self.paused = not paused 
		scene_tree.set_input_as_handled()



func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value


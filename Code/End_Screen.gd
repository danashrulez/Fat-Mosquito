extends Control

onready var label: Label = get_node("Label")

func _ready():
	$death.play()
	label.text = label.text %[PlayerData.score, PlayerData.deaths]


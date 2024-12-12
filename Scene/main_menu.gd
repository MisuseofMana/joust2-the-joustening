extends CanvasLayer
class_name MainMenu

@onready var host_button = $PanelContainer/MarginContainer/VBoxContainer/HostButton
@onready var join_button = $PanelContainer/MarginContainer/VBoxContainer/JoinButton
@export var world_node : World = null

func _ready():
	host_button.pressed.connect(world_node.hostButtonPressed)
	join_button.pressed.connect(world_node.joinButtonPressed)

func _process(delta):
	pass

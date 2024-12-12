extends CanvasLayer
class_name MainMenu

@onready var host_button = $MainMenu/MarginContainer/VBoxContainer/HostButton
@onready var join_button = $MainMenu/MarginContainer/VBoxContainer/JoinButton
@onready var address_entry = $MainMenu/MarginContainer/VBoxContainer/AddressEntry
@onready var main_menu = $MainMenu

@export var world_node : World = null

func _ready():
	host_button.pressed.connect(world_node.hostButtonPressed)
	join_button.pressed.connect(world_node.joinButtonPressed)

func _process(delta):
	pass

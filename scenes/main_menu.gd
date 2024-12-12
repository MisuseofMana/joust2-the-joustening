extends Node
class_name MainMenu

@export var address_entry : LineEdit
@export var connecting_label : Label
@export var level_container : Node
@export var level_scene : PackedScene
@export var not_connected_vbox : VBoxContainer
@export var host_vbox : VBoxContainer
@export var ui : PanelContainer

func _ready():
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	
func _process(delta):
	pass

func _on_host_button_pressed():
	not_connected_vbox.hide()
	host_vbox.show()
	Lobby.create_game()
	connecting_label.text = "Hosting!"
	
func _on_join_button_pressed():
	not_connected_vbox.hide()
	Lobby.join_game(address_entry.text)
	connecting_label.text = "Connecting..."
	
func _on_start_button_pressed():
	hide_menu.rpc()
	_change_level.call_deferred(level_scene)
	
func _change_level(scene):
	for child in level_container.get_children():
		level_container.remove_child(child)
		child.queue_free()
	level_container.add_child(scene.instantiate())
	
func _on_connection_failed():
	connecting_label.text = "Failed to connect"
	not_connected_vbox.show()

func _on_connected_to_server():
	connecting_label.text = "Connected!"

@rpc("call_local", "authority", "reliable")
func hide_menu():
	ui.hide()

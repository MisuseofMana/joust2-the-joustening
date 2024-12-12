extends Node
class_name World

@onready var canvas = $Canvas

const PLAYER = preload("res://actors/player.tscn")

const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func hostButtonPressed():
	canvas.main_menu.hide()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	add_player(multiplayer.get_unique_id())
	print('host')
	
func joinButtonPressed():
	canvas.main_menu.hide()
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer
	add_player(multiplayer.get_unique_id())
	print('join')
	
func add_player(peer_id):
	var player = PLAYER.instantiate()
	player.name = str(peer_id)
	add_child(player)
	print(peer_id)
	pass

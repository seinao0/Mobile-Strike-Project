extends Node

const DEFAULT_PORT = 8910
const MAX_PLAYERS = 16

var peer = ENetMultiplayerPeer.new()
var player_list = {} # {id: name}

signal player_connected(id)
signal player_disconnected(id)
signal connection_failed

func _ready():
    multiplayer.multiplayer_peer = peer
    multiplayer.peer_connected.connect(_on_peer_connected)
    multiplayer.peer_disconnected.connect(_on_peer_disconnected)
    multiplayer.connection_failed.connect(_on_connection_failed)

func create_server(player_name):
    var error = peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
    if error != OK:
        print("Could not create server: %s" % error)
        return false
    
    player_list[multiplayer.get_unique_id()] = player_name
    print("Server created. ID: %d" % multiplayer.get_unique_id())
    return true

func join_server(ip, player_name):
    var error = peer.create_client(ip, DEFAULT_PORT)
    if error != OK:
        print("Could not create client: %s" % error)
        return false
    
    player_list[multiplayer.get_unique_id()] = player_name
    print("Client connecting...")
    return true

func _on_peer_connected(id):
    print("Player connected: %d" % id)
    # Se for o servidor, pede o nome do novo jogador
    if multiplayer.is_server():
        rpc_id(id, "request_player_info")
    
    player_connected.emit(id)

func _on_peer_disconnected(id):
    print("Player disconnected: %d" % id)
    if player_list.has(id):
        player_list.erase(id)
    player_disconnected.emit(id)

func _on_connection_failed():
    print("Connection failed.")
    connection_failed.emit()

@rpc("any_peer", "call_local")
func request_player_info():
    # Chamado pelo servidor para o cliente
    rpc_id(1, "send_player_info", multiplayer.get_unique_id(), player_list[multiplayer.get_unique_id()])

@rpc("any_peer")
func send_player_info(id, name):
    # Chamado pelo cliente para o servidor (ID 1)
    if not player_list.has(id):
        player_list[id] = name
        print("Received player info: %d - %s" % [id, name])
    
    # Se for o servidor, replica a informação para todos os outros clientes
    if multiplayer.is_server():
        rpc("send_player_info", id, name)

func get_player_list():
    return player_list

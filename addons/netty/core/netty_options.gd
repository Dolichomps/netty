extends Resource
class_name NettyOptions

export var server_ip: String
export var server_port: int
export var max_peers: int
export var game_scene: PackedScene
export var player_scenes: Array

func _init(p_server_ip: String = "127.0.0.1", p_server_port: int = 0, p_max_peers: int = 0, p_game_scene: PackedScene = null, p_player_scenes: Array = []) -> void:
	server_ip = p_server_ip
	server_port = p_server_port
	max_peers = p_max_peers
	game_scene = p_game_scene
	player_scenes = p_player_scenes
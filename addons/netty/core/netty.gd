extends Node
class_name Netty, "res://addons/netty/resources/netty_icon.svg"

var options: NettyOptions
var parent_node: Node
var is_hosting: bool = false
var is_connected_to_host: bool = false

func _init(p_options: Resource, node: Node) -> void:
	options = p_options
	parent_node = node

func start() -> void:
	if self.is_inside_tree():
		print("Netty: Already initialized in tree, will not reinitialize.")
		return
	parent_node.add_child(self)
	add_to_group("Netty", true)
	if get_tree().get_nodes_in_group("Netty").size() > 1:
		push_error("Netty: More than one instance of Netty exists. There can only be one.")
		assert(false)
	var ERR
	ERR = get_tree().connect("network_peer_connected", self, "_player_connected")
	ERR = get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	ERR = get_tree().connect("connected_to_server", self, "_connection_success")
	ERR = get_tree().connect("connection_failed", self, "_connection_failed")
	ERR = get_tree().connect("server_disconnected", self, "_server_disconnected")
	if ERR != OK:
		push_error("Netty: Failed to initilize with error code: " + str(ERR) + ". View @GlobalScope enum Error for more info.")
		assert(false)
	else:
		print("Netty: Initialized! Using options from " + str(options.resource_path) + ".")

func _connection_success() -> void:
	if !get_tree().is_network_server():
		print("Netty Peer: Connected to server!")

func _player_connected(id) -> void:
	if get_tree().is_network_server():
		print("Netty Server: Peer connected!" + str(id))

func shutdown() -> void:
	if !self.is_inside_tree():
		print("Netty: Not initialized, nothing to shutdown.")
		return
	get_tree().disconnect("network_peer_connected", self, "_player_connected")
	get_tree().disconnect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().disconnect("connected_to_server", self, "_connection_success")
	get_tree().disconnect("connection_failed", self, "_connection_failed")
	get_tree().disconnect("server_disconnected", self, "_server_disconnected")
	get_tree().set_network_peer(null)
	print("Netty: Shutdown.")
	is_hosting = false
	parent_node.remove_child(self)

func host_session() -> void:
	if is_hosting == true:
		print("Netty: Aready hosting a session, will not retry.")
		return
	var host: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	var ERR = host.create_server(options.server_port, options.max_peers)
	if ERR != OK:
		push_error("Netty: Failed to start hosting session with error code: " + str(ERR) + ". View @GlobalScope enum Error for more info.")
		assert(false)
	print("Netty: Hosting a server on port: " + str(options.server_port) + ".")
	get_tree().set_network_peer(host)
	is_hosting = true

func join_session() -> void:
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	var ERR = peer.create_client(options.server_ip, options.server_port)
	if ERR != OK:
		push_error("Netty: Failed to join hosting session with error code: " + str(ERR) + ". View @GlobalScope enum Error for more info.")
		assert(false)
	print("Netty: Trying to join session with IP: " + str(options.server_ip) + " on port: " + str(options.server_port) + ".")
	get_tree().set_network_peer(peer)

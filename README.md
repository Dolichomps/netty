# netty
A simple way to manage multiplayer in Godot

## netty is a work in progress
As such you may encounter errors or it may downright not work at all.
The API may also change overtime as netty is under rapid development

## features (working list, will be updated)
- [x] start and stop networking at will
- [x] use custom resource to pass values to server upon initialization
  - e.g. max peers, server ip, server port, etc..
- [x] easy hosting and joining of session
  - `Netty.host_session()` and `Netty.join_session()`
- [ ] allow use of a custom scene for each peer on the network
  - or use of instances of the same scene
- [ ] library of common network calls
  - e.g. sync rotation or position
 
 ## usage
 - copy the addons folder into the root of your Godot project
 - initialize netty from script using `Netty.new(options: NettyOptions, parent_node: Node)`
   - e.g `var netty: Netty = Netty.new(preload("res://addons/netty/NettyOptions.tres"), self)`
 - start netty with `Netty.start()`
 - stop netty with `Netty.shutdown()`
 - there is a deault NettyOptions resource in `res://addons/netty/NettyOptions.tres`
   - double click it in the file system dock to view it and edit its settings
 

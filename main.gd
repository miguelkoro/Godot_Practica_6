extends Node2D

const PLAYER = preload("uid://dxj6qigga6jhd")

@onready var tile_map_layer: TileMapLayer = $TileMapLayer


var agent: Node2D
var spawn: bool = false
var destiny: bool = false

var walkableCell: Vector2i = Vector2i(7,9)


func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
	if Input.is_action_just_pressed("set_target"):
		var mouse_global = get_global_mouse_position()#tile_map_layer.get_global_mouse_position()
		var cell = tile_map_layer.local_to_map(mouse_global)
		print(walkable_cell(cell))
		if not walkable_cell(cell): #Comprobar si la celda se puede caminar
			return
		if spawn and destiny:
			recreate_map()
		elif not spawn:
			spawn_agent(mouse_global)
		else:
			set_agent_target(mouse_global)

func walkable_cell(cell: Vector2i) -> bool:
	var atlas = tile_map_layer.get_cell_atlas_coords(cell)
	if atlas==walkableCell:		
		return true
	else: 
		return false

func spawn_agent(mouse_global: Vector2) -> void:
	agent = PLAYER.instantiate()
	add_child(agent)
	agent.global_position = mouse_global
	spawn = true
	
	#agent.navigation_agent_2d.set_navigation_map(tile_map_layer.navigation_map)
	#agent.global_position = mouse_global#tile_map_layer.map_to_local(cell) #Coloca el player en la posicion de la tile
	
func set_agent_target(mouse_global: Vector2) -> void:
	#var point = tile_map_layer.map_to_local(cell)
	#agent.manual_navigation(mouse_global)
	agent.manual_navigation(mouse_global)
	destiny = true
	
func recreate_map() -> void:
	agent.queue_free() #Elimino el player
	destiny = false
	spawn = false
	tile_map_layer.create_map()

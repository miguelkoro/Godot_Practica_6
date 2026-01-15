extends Area2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var debug_label: Label = $DebugLabel

@export var speed: float = 100
var navigationBool: bool = false



func _physics_process(delta: float) -> void:
	debug_label.text = "Done: %s \nHit target:%s \n Target reachable:%s" %[
		navigation_agent_2d.is_navigation_finished(),
		navigation_agent_2d.is_target_reached(),
		navigation_agent_2d.is_target_reachable()
	]
	if navigation_agent_2d.is_target_reached(): #Si se ha alcanzado el objetivo se ejecuta el finishied.walking del singleton
		GameManager.finished_walking()
	elif not navigation_agent_2d.is_target_reachable() and navigationBool and navigation_agent_2d.is_navigation_finished(): 
		GameManager.no_reachable() #Si ha acabado de navegar y no se alcanza el objetivo, se ejecuta el metodono_reachable
		navigationBool = false
	#manual_navigation()
	navigate(delta)

func manual_navigation(position: Vector2) -> void:
	if Input.is_action_just_pressed("set_target"):
		navigation_agent_2d.target_position = position #Añade la posicion al navegador 2d
		navigationBool = true #indica que ha empezado a navegar

func navigate(delta: float) -> void: #navega al punto que le hemos puesto
	if navigation_agent_2d.is_navigation_finished(): #Si ha terminado de navegar
		return
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	var new_velocity: Vector2 = (global_position.direction_to(next_path_position)* speed)
	position += new_velocity * delta

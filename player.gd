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
	if navigation_agent_2d.is_target_reached():
		GameManager.finished_walking()
	elif not navigation_agent_2d.is_target_reachable() and navigationBool and navigation_agent_2d.is_navigation_finished(): 
		GameManager.no_reachable()
		navigationBool = false
	#manual_navigation()
	navigate(delta)

func manual_navigation(position: Vector2) -> void:
	if Input.is_action_just_pressed("set_target"):
		navigation_agent_2d.target_position = position
		navigationBool = true

func navigate(delta: float) -> void:
	if navigation_agent_2d.is_navigation_finished():
		return
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	var new_velocity: Vector2 = (global_position.direction_to(next_path_position)* speed)
	position += new_velocity * delta

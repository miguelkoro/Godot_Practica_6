extends Area2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var debug_label: Label = $DebugLabel

@export var speed: float = 100

func _physics_process(delta: float) -> void:
	debug_label.text = "Done: %s \nHit target:%s \n Target reachable:%s" %[
		navigation_agent_2d.is_navigation_finished(),
		navigation_agent_2d.is_target_reached(),
		navigation_agent_2d.is_target_reachable()
	]
	
	manual_navigation()
	navigate(delta)

func manual_navigation() -> void:
	if Input.is_action_just_pressed("set_target"):
		navigation_agent_2d.target_position = get_global_mouse_position()

func navigate(delta: float) -> void:
	if navigation_agent_2d.is_navigation_finished():
		return
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	var new_velocity: Vector2 = (global_position.direction_to(next_path_position)* speed)
	position += new_velocity * delta

extends Node
#Para cuando recorre el camino y llega al final
func finished_walking() -> void:
	var scene = get_tree().get_first_node_in_group("Scene")
	print("terminao")
	scene.finished_walking()
	
func no_reachable() ->void:
	var scene = get_tree().get_first_node_in_group("Scene")
	print("no accesible")
	scene.no_accesible()
	#scene.finished_walking()

extends TileMapLayer
@export var noise: FastNoiseLite
@export var sc: float = 0.1
@export var height_sc: float = 10

#@export var atlas_arr = [Vector2i(1,1),Vector2i(7,1),Vector2i(12,1),Vector2i(7,5)]
@export var atlas_arr = [Vector2i(7,9),Vector2i(18,5),Vector2i(17,6)]

func _ready() -> void:
	create_map()
	
func create_map() -> void:
	noise.seed = randi() #Crea una semilla aleatoria
	for i in range(20):
		for j in range(20):
			var x: float = i#randf_range(-50,50)
			var y: float = j#randf_range(-50,50)
					
			var height = noise.get_noise_2d(x/sc,y/sc)
			height = (height+1)/2
			#var int_height = height as int
			var vect_to_use: Vector2i  
			if height < 0.5:
				vect_to_use=atlas_arr[0]
			elif height < 0.75:
				vect_to_use=atlas_arr[1]
			#elif height < 0.75:
			#	vect_to_use=atlas_arr[2]
			else:
				vect_to_use=atlas_arr[2]
			#var newNode := BALL.instantiate()	
			set_cell(Vector2i(x,y),0,vect_to_use)

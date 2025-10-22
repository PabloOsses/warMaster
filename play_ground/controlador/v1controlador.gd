extends Node2D

var selected_unit: CharacterBody2D = null
var enemy_unit: CharacterBody2D = null

var cantUnitsJugador:int=0
var cantUnitsEnemigo:int=0
var phase = "moving"
@onready var labelPhase:Label = $UIComponent/VisionDeCampo/LabelPhase
@onready var labelJugador:Label=$UIComponent/VisionDeCampo/LabelJugador
func _ready():
	labelPhase.text = "Fase: "+phase
	add_to_group("control")
	cantUnitsJugador = (get_tree().get_nodes_in_group("faction_player")).size()
	cantUnitsEnemigo= (get_tree().get_nodes_in_group("faction_enemy")).size()
	print("cant jugador: ", cantUnitsJugador)
	print("cant Enemigo: ", cantUnitsEnemigo)
func _process(delta: float) -> void:
	# IMPORTANTE click izquierdo → seleccionar unidad
	if Input.is_action_just_pressed("left_click"):
		var clicked_unit = _get_unit_under_mouse()
		print("ELEGIDO: ", clicked_unit)
		if clicked_unit:
			selected_unit = clicked_unit
			print("Seleccionada:", selected_unit.name)
			#print("Estado area: ". clicked_unit.name.moving)
		else:
			selected_unit = null
			print("Nada seleccionado")

	# IMPORTANTE click  derecho mover/
	# De aqui la logica de click derecho
	#MOVIMIENTO
	elif Input.is_action_just_pressed("right_click") and selected_unit==null:
		print("NO HAY UNIDAD SELECCIONADA")
		
	elif Input.is_action_just_pressed("right_click") and selected_unit.is_in_group("faction_player"):
		enemy_unit=_get_enemy_under_mouse()
	#CONTACTO enemigo
		match phase:
			"moving":
				_mov_phase()
			"fire":
				if enemy_unit:
					if selected_unit.dentro_rango_disparo:
						selected_unit.dentro_rango_disparo = true
						#print("FUEGO")
						#print("ENEMY NAME, ",enemy_unit.name)
						_fire_phase(selected_unit,enemy_unit)
	
func _get_unit_under_mouse() -> CharacterBody2D:
	var params := PhysicsPointQueryParameters2D.new()
	params.position = get_global_mouse_position()
	params.collide_with_areas = true

	var results = get_world_2d().direct_space_state.intersect_point(params, 8)

	for r in results:
		var collider = r.get("collider")
		if collider and collider.is_in_group("faction_player"):
			return collider
		
	return null
func _get_enemy_under_mouse() -> CharacterBody2D:
	var params := PhysicsPointQueryParameters2D.new()
	params.position = get_global_mouse_position()
	params.collide_with_areas = true

	var results = get_world_2d().direct_space_state.intersect_point(params, 8)

	for r in results:
		var collider = r.get("collider")
		if collider and collider.is_in_group("faction_enemy"):
			return collider
	return null
func _mov_phase()->void:
	var target = get_global_mouse_position()
	enemy_unit=null
	selected_unit.target_position = target
	if selected_unit.dentro_radio_mov:
		selected_unit.moving = true
	pass
	
func _fire_phase(firing_unit: CharacterBody2D,reciver_unit: CharacterBody2D)->void:
	print("FIRE PHASE: ", firing_unit.name)
	print("FIRE PHASE: ", reciver_unit.name)
	var numerosGenerados=[]
	#generacion de tiros
	for i in firing_unit.unit_size:
		numerosGenerados.append(randi_range(1, 6))  
	#tiros que dan al blanco
	var contadorTirosdentro=0
	for i in numerosGenerados:
		if i>=firing_unit.unit_b_skill:
			contadorTirosdentro+=1
	#tiros que son resistidos?
	var tirosHaResistir=0
	for i in reciver_unit.unit_size:
		var tiroT=randi_range(1, 6) 
		if reciver_unit.unit_streght==firing_unit.weaponStreght:
			#TO DO TO DO TO DO
			print("caso mismo S y T :", tiroT)
			if tiroT>=4:
				tirosHaResistir+=1
				
			pass
	#tirada de salvar
	var danioRecibido=0
	for i in tirosHaResistir:
		var tiroS=randi_range(1, 6) 
		if reciver_unit.unit_save<tiroS:
			danioRecibido+=1
		pass
	reciver_unit.units_wounds_pool=reciver_unit.units_wounds_pool-danioRecibido
	print("NUMEROS GENERADOS: ",numerosGenerados)
	print("TIROS acertados: ",contadorTirosdentro)
	print("DENTRO DEL SUJETO: ",tirosHaResistir)
	print("daño recibido: ", danioRecibido)
	pass


func _on_cambio_fase_pressed() -> void:
	if phase == "moving":
		phase="fire"
	elif phase == "fire":
		phase="moving"
	else:
		print("PROBLEMA EN FASES")
	labelPhase.text = "Fase: "+phase
	pass # Replace with function body.


func _on_cambio_jugador_pressed() -> void:
	labelJugador.text = "HACER BOTON "
	pass # Replace with function body.

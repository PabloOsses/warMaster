extends Node2D

var selected_unit: CharacterBody2D = null
var enemy_unit: CharacterBody2D = null

func _ready():
	add_to_group("control")

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		# IMPORTANTE click izquierdo → seleccionar unidad
		if event.button_index == MOUSE_BUTTON_LEFT:
			var clicked_unit = _get_unit_under_mouse()
			
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
		elif event.button_index == MOUSE_BUTTON_RIGHT and selected_unit.is_in_group("faction_player"):
			enemy_unit=_get_enemy_under_mouse()
			var target = get_global_mouse_position()
		#CONTACTO
			if enemy_unit:
				if selected_unit.dentro_rango_disparo:
					selected_unit.dentro_rango_disparo = true
					#print("FUEGO")
					#print("ENEMY NAME, ",enemy_unit.name)
					_fire_phase(selected_unit,enemy_unit)
			else:
				enemy_unit=null
				selected_unit.target_position = target
				if selected_unit.dentro_radio_mov:
					selected_unit.moving = true
	
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
func _fire_phase(selected_unit: CharacterBody2D,enemy_unit: CharacterBody2D)->void:
	print("FIRE PHASE: ", selected_unit.name)
	print("FIRE PHASE: ", enemy_unit.name)
	enemy_unit.eliminar()
	pass

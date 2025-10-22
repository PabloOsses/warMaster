extends CharacterBody2D

@export var speed: float = 200.0
@export var unit_size:int=10
@export var unit_wounds:int=1
var units_wounds_pool:int= unit_size*unit_wounds
@export var unit_b_skill:int=4
@export var unit_m_skill:int=4
@export var unit_tougness:int=4
@export var unit_streght:int=4
@export var unit_save:int=4

@onready var radio_area_movimiento=$areamov/CollisionShape2D
@onready var radio_area_disparo=$areaDisparo/CollisionShape2D

@export var radio_movimiento_valor:float=30.0
var target_position: Vector2
var moving: bool = false
var dentro_radio_mov:bool=false
var dentro_rango_disparo:bool=false

var weaponLoadauts={
	"gunTest": [120,4,0],
}
var weaponEquiped= weaponLoadauts["gunTest"]
var weaponStreght=weaponLoadauts["gunTest"][1]
func _ready():
	target_position = global_position
	add_to_group("faction_enemy")
	radio_area_movimiento.shape.radius=radio_movimiento_valor
	radio_area_disparo.shape.radius=weaponEquiped[0]
func _process(delta):
	if moving:
		var dir = target_position - global_position
		var distance = dir.length()

		if distance > 1.0:
			dir = dir.normalized()
			# Mover solo hasta el punto, sin pasarse
			var move_step = min(distance, speed * delta)
			global_position += dir * move_step
		else:
			# Al llegar, fijar posición final y detener movimiento
			global_position = target_position
			moving = false
	if units_wounds_pool <=0:
		eliminar()

func _on_areamov_mouse_entered() -> void:
	dentro_radio_mov=true
	#print("Unit PUEDE moverse")
	pass # Replace with function body.


func _on_areamov_mouse_exited() -> void:
	dentro_radio_mov=false
	#print("Unit NO puede moverse")
	pass # Replace with function body.


func _on_area_disparo_mouse_entered() -> void:
	dentro_rango_disparo=true
	print("DENTRO del rango de disparo")
	pass # Replace with function body.


func _on_area_disparo_mouse_exited() -> void:
	dentro_rango_disparo=false
	print("FUERA del rango de disparo")
	pass # Replace with function body.
	
func eliminar():
	print("UNIDAD ELIMINADA")
	queue_free()

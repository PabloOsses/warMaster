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

func _ready() -> void:
	add_to_group("faction_enemy")
	pass
func _physics_process(delta: float) -> void:
	if units_wounds_pool <=0:
		eliminar()
	pass

func eliminar():
	print("UNIDAD ELIMINADA")
	queue_free()

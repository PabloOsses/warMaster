extends CharacterBody2D

func _ready() -> void:
	add_to_group("faction_enemy")
	pass
func _physics_process(delta: float) -> void:
	pass

func eliminar():
	queue_free()

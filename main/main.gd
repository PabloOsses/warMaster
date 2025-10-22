extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("MAIN")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().change_scene_to_file("res://tests_levels/level_0/scenes/test_0.tscn")
	pass

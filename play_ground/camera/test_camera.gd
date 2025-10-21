extends Camera2D

@export var move_speed: float = 400.0
@export var map_limits := Rect2(Vector2(0, 0), Vector2(1500, 1000))
func _process(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		position += input_vector * move_speed * delta
	# limite dentro del mapa
	var half_screen = get_viewport_rect().size / 2
	position.x = clamp(position.x, map_limits.position.x + half_screen.x, map_limits.end.x - half_screen.x)
	position.y = clamp(position.y, map_limits.position.y + half_screen.y, map_limits.end.y - half_screen.y)

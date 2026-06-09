class_name GraphArea

extends Control

var function_to_draw: Callable = func(_x: float) -> float: return 0.0
var function_name: String = ""
var scale_factor: float = 50.0

func set_function(fn: Callable, fname: String) -> void:
	function_to_draw = fn
	function_name = fname
	queue_redraw()

func _draw() -> void:
	var center: Vector2 = Vector2(size.x / 2.0, size.y / 2.0)
	var grid_color: Color = Color(0.1, 0.1, 0.1, 0.2)
	var axis_color: Color = Color(0.2, 0.2, 0.2, 0.9)
	var graph_color: Color = Color(0.9, 0.2, 0.2, 1.0)

	var step: float = scale_factor
	var i: float = 0.0
	while center.x + i * step < size.x or center.x - i * step > 0 or center.y + i * step < size.y or center.y - i * step > 0:
		if i > 0:
			var x_offset: float = i * step
			if center.x + x_offset < size.x:
				draw_line(Vector2(center.x + x_offset, 0), Vector2(center.x + x_offset, size.y), grid_color, 1.0)
			if center.x - x_offset > 0:
				draw_line(Vector2(center.x - x_offset, 0), Vector2(center.x - x_offset, size.y), grid_color, 1.0)
			if center.y + x_offset < size.y:
				draw_line(Vector2(0, center.y + x_offset), Vector2(size.x, center.y + x_offset), grid_color, 1.0)
			if center.y - x_offset > 0:
				draw_line(Vector2(0, center.y - x_offset), Vector2(size.x, center.y - x_offset), grid_color, 1.0)
		i += 1.0

	draw_line(Vector2(center.x, 0), Vector2(center.x, size.y), axis_color, 2.0)
	draw_line(Vector2(0, center.y), Vector2(size.x, center.y), axis_color, 2.0)

	var points: PackedVector2Array = PackedVector2Array()
	var left_world: float = -center.x / scale_factor
	var right_world: float = (size.x - center.x) / scale_factor
	var x: float = left_world
	var step_x: float = 1.0 / scale_factor

	while x <= right_world:
		var y: float = function_to_draw.call(x)
		if not is_nan(y) and not is_inf(y):
			var screen_x: float = center.x + x * scale_factor
			var screen_y: float = center.y - y * scale_factor
			if screen_y >= 0.0 and screen_y <= size.y:
				points.append(Vector2(screen_x, screen_y))
			else:
				if points.size() > 1:
					draw_polyline(points, graph_color, 2.0)
				points.clear()
		else:
			if points.size() > 1:
				draw_polyline(points, graph_color, 2.0)
			points.clear()
		x += step_x

	if points.size() > 1:
		draw_polyline(points, graph_color, 2.0)

	var font: Font = ThemeDB.fallback_font
	var font_size: int = 24
	var label_color: Color = Color(0.1, 0.1, 0.1, 1.0)
	draw_string(font, Vector2(size.x - 20, center.y - 10), "x", HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, label_color)
	draw_string(font, Vector2(center.x + 10, 15), "y", HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, label_color)
	draw_string(font, Vector2(center.x - 20, center.y + 22), "0", HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, label_color)
	draw_string(font, Vector2(center.x + 40, center.y + 22), "1", HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, label_color)
	draw_string(font, Vector2(center.x - 20, center.y - 40), "1", HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, label_color)

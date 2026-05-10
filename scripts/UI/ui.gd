class_name UI
extends Control
## Main class controling UI.


enum Views {
	BASE_CLICKER,
	BASE_GENERATOR,
}

signal navigation_requested(view : Views)


func _on_base_clicker_link_pressed() -> void:
	navigation_requested.emit(Views.BASE_CLICKER)


func _on_base_generator_link_pressed() -> void:
	navigation_requested.emit(Views.BASE_GENERATOR)

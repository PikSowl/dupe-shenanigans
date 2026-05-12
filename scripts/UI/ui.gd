class_name UI
extends Control
## Main class controling UI.


enum Views {
	BASE_CLICKER,
	BASE_GENERATOR,
	BASE_UPGRADE,
	SPACETIME_FORGE
}

signal navigation_requested(view : Views)


func _on_base_clicker_link_pressed() -> void:
	navigation_requested.emit(Views.BASE_CLICKER)


func _on_base_generator_link_pressed() -> void:
	navigation_requested.emit(Views.BASE_GENERATOR)


func _on_base_upgrade_link_pressed() -> void:
	navigation_requested.emit(Views.BASE_UPGRADE)


func _on_stf_link_pressed() -> void:
	navigation_requested.emit(Views.SPACETIME_FORGE)

class_name BaseClicker
extends Control
## Basic clicker. Click on button == +1 energy.


@export var ui : UI

@export var view : UI.Views


func _ready() -> void:
	visible = true
		
	ui.navigation_requested.connect(_on_navigation_request)


func _on_button_pressed() -> void:
	create_energy()


func create_energy() -> void:
	HandlerEnergy.ref.create_energy(1)


func _on_navigation_request(requested_view : UI.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false

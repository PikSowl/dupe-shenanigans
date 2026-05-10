class_name BaseClicker
extends Control
## Basic clicker. Click on button == +1 energy.


@export var e_counter : Label

@export var ui : UI

@export var view : UI.Views

var energy : int = 0


func _ready() -> void:
	update_label_text()
	
	visible = true
		
	ui.navigation_requested.connect(_on_navigation_request)


func _on_button_pressed() -> void:
	create_energy()


func create_energy() -> void:
	energy += 1
	update_label_text()


func update_label_text() -> void:
	e_counter.text = "Energy : %s" % energy


func _on_navigation_request(requested_view : UI.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false

class_name BaseGenerator
extends Control
## Basic generator. When on, adds 1 energy/second.

## Button to turn on generator
@export var button : Button
## Timer between income
@export var timer : Timer

@export var ui : UI

@export var view : UI.Views


func _ready() -> void:
	visible = false
	
	ui.navigation_requested.connect(_on_navigation_request)


func _on_timer_timeout() -> void:
	create_energy()


func _on_button_pressed() -> void:
	begin_generating_basic_energy()


## Start to generete energy in timer wait time intervals
func begin_generating_basic_energy() -> void:
	timer.start()
	button.disabled = true


func create_energy() -> void:
	HandlerEnergy.ref.create_energy(1)


func _on_navigation_request(requested_view : UI.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false

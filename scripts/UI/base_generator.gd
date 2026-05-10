class_name BaseGenerator
extends Control
## Basic generator. When on, adds 1 energy/second.

## Label that displays energy
@export var e_counter : Label
## Button to turn on generator
@export var button : Button
## Timer between income
@export var timer : Timer

@export var ui : UI

@export var view : UI.Views


func _ready() -> void:
	update_label_text()
	
	visible = false
	
	ui.navigation_requested.connect(_on_navigation_request)


## TEMP Function to update label
func _process(_delta: float) -> void:
	update_label_text()


func _on_timer_timeout() -> void:
	create_energy()


func _on_button_pressed() -> void:
	begin_generating_basic_energy()


## Start to generete energy in timer wait time intervals
func begin_generating_basic_energy() -> void:
	timer.start()
	button.disabled = true


func create_energy() -> void:
	Game.ref.data.energy += 1


func update_label_text() -> void:
	e_counter.set_text("Energy : %s" % Game.ref.data.energy)


func _on_navigation_request(requested_view : UI.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false

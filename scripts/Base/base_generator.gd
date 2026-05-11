class_name BaseGenerator
extends View
## Basic generator. When on, adds 1 energy/second.

## Button to turn on generator
@export var button : Button
## Timer between income
@export var timer : Timer

func _ready() -> void:
	super()
	visible = false


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

class_name BaseClicker
extends View
## Basic clicker. Click on button == +1 energy.

func _ready() -> void:
	super()
	visible = true


func _on_button_pressed() -> void:
	create_energy()


func create_energy() -> void:
	HandlerEnergy.ref.click_energy()

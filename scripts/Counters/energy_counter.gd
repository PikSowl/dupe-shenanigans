class_name EnergyCounter
extends Label
## Displays the curent amount of stored energy.

## Conecting signals
func _ready() -> void:
	update_text(0)
	HandlerEnergy.ref.energy_created.connect(update_text)
	HandlerEnergy.ref.energy_consumed.connect(update_text)


## Updates the text to show curent stored energy 
func update_text(_quantity : int = -1) -> void:
	set_text("Энергия : %s" % Game.ref.data.energy)

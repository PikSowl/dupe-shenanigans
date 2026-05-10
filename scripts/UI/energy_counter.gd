class_name EnergyCounter
extends Label
## Displays the curent amount of stored energy .

## TEMP Function to update label
func _process(_delta: float) -> void:
	update_text()


## Updates the text to show curent stored energy 
func update_text() -> void:
	set_text("Energy : %s" % Game.ref.data.energy)

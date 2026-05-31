class_name STRCounter
extends Label
## Displays the curent amount of stored STR.

## Conecting signals
func _ready() -> void:
	update_text(0)
	HandlerSTR.ref.st_r_created.connect(update_text)
	HandlerSTR.ref.st_r_consumed.connect(update_text)


## Updates the text to show curent stored STR 
func update_text(_quantity : int = -1) -> void:
	set_text("ЗВД : %s" % Game.ref.data.st_r)

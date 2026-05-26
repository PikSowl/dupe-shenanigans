class_name HandlerSimonFunel
extends Node
## Alows to acsess simpn mini-game.

## Singleton reference
static var ref : HandlerSimonFunel


## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


signal simon_open()


func _ready() -> void:
	if Game.ref.data.stf.stf_3_forged:
		simon_open.emit()
		return
	
	HandlerSTForge.ref.stf_3_simon_funel.bought.connect(watch_for_stf_3_get_forged)


## Wait for CoalPlant to be purchased
func watch_for_stf_3_get_forged() -> void:
	simon_open.emit()
	HandlerSTForge.ref.stf_3_simon_funel.bought.disconnect(watch_for_stf_3_get_forged)

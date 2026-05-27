class_name HandlerMiniFunel
extends Node
## Alows to acsess to various mini-games.

## Singleton reference
static var ref : HandlerMiniFunel


## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


signal simon_open()
signal func_quiz_open()


func _ready() -> void:
	if Game.ref.data.stf.stf_3_forged:
		simon_open.emit()
		return
	else:
		HandlerSTForge.ref.stf_3_simon_funel.bought.connect(watch_for_stf_3_get_forged)
	if Game.ref.data.stf.stf_4_forged:
		simon_open.emit()
		return
	else:
		HandlerSTForge.ref.stf_4_func_quiz_funel.bought.connect(watch_for_stf_4_get_forged)


## Wait for Simon Funel to be purchased
func watch_for_stf_3_get_forged() -> void:
	simon_open.emit()
	HandlerSTForge.ref.stf_3_simon_funel.bought.disconnect(watch_for_stf_3_get_forged)

## Wait for Func Quiz Funel to be purchased
func watch_for_stf_4_get_forged() -> void:
	func_quiz_open.emit()
	HandlerSTForge.ref.stf_4_func_quiz_funel.bought.disconnect(watch_for_stf_4_get_forged)

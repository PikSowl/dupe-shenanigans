class_name HandlerMiniFunnel
extends Node
## Alows to acsess to various mini-games.

## Singleton reference
static var ref : HandlerMiniFunnel


## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


signal simon_open()
signal func_quiz_open()
signal reaction_open()


func _ready() -> void:
	await(get_tree().create_timer(0.1).timeout)
	if Game.ref.data.stf.stf_3_forged:
		simon_open.emit()
	else:
		HandlerSTForge.ref.stf_3_simon_funnel.bought.connect(watch_for_stf_3_get_forged)
	
	if Game.ref.data.stf.stf_4_forged:
		func_quiz_open.emit()
	else:
		HandlerSTForge.ref.stf_4_func_quiz_funnel.bought.connect(watch_for_stf_4_get_forged)
	
	if Game.ref.data.stf.stf_5_forged:
		reaction_open.emit()
	else:
		HandlerSTForge.ref.stf_5_reaction_funnel.bought.connect(watch_for_stf_5_get_forged)


## Wait for Simon Funnel to be purchased
func watch_for_stf_3_get_forged() -> void:
	simon_open.emit()
	HandlerSTForge.ref.stf_3_simon_funnel.bought.disconnect(watch_for_stf_3_get_forged)

## Wait for Func Quiz Funnel to be purchased
func watch_for_stf_4_get_forged() -> void:
	func_quiz_open.emit()
	HandlerSTForge.ref.stf_4_func_quiz_funnel.bought.disconnect(watch_for_stf_4_get_forged)

## Wait for Reaction Funnel to be purchased
func watch_for_stf_5_get_forged() -> void:
	reaction_open.emit()
	HandlerSTForge.ref.stf_5_reaction_funnel.bought.disconnect(watch_for_stf_5_get_forged)

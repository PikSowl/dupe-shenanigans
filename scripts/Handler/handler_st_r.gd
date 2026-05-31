class_name HandlerSTR
extends Node
## Manage STR and STR signals.


## Singleton reference
static var ref : HandlerSTR


## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


signal st_r_created()

signal st_r_consumed()


## Return curent stored STR
func st_r() -> int:
	return Game.ref.data.st_r


## Add some quantity of STR to stored
func create_st_r(quantity : int) -> void:
	Game.ref.data.st_r += quantity
	st_r_created.emit()


## Try to consume some quantity of STR from stored
func consume_st_r(quantity : int) -> Error:
	if quantity > Game.ref.data.st_r:
		return Error.FAILED
	
	Game.ref.data.st_r -= quantity
	st_r_consumed.emit()
	
	return Error.OK

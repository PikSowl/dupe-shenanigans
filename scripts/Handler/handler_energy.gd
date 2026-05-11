class_name HandlerEnergy
extends Node
## Manage energy and energy signals.


## Singleton reference
static var ref : HandlerEnergy


## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


signal energy_created(quantity : int)

signal energy_consumed(quantity : int)


## Return curent stored energy
func energy() -> int:
	return Game.ref.data.energy


## Add some quantity of energy to stored
func create_energy(quantity : int) -> void:
	Game.ref.data.energy += quantity
	energy_created.emit(quantity)


## Try to consume some quantity of energy from stored
func consume_energy(quantity : int) -> Error:
	if quantity > Game.ref.data.energy:
		return Error.FAILED
	
	Game.ref.data.energy -= quantity
	energy_consumed.emit(quantity)
	
	return Error.OK

## When click produce energy
func click_energy() -> void:
	var quantity_added: int = 1
	quantity_added += Game.ref.data.up_c_1_amount
	
	create_energy(quantity_added)

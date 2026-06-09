class_name HandlerEnergy
extends Node
## Manage energy and energy signals.


## Singleton reference
static var ref : HandlerEnergy

var n : int = 0
var energy_for_next_str : int = 1000 * int(pow(10, n))

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()
	n = Game.ref.data.str_from_energy_gained


signal energy_created()

signal energy_consumed()


## Return curent stored energy
func energy() -> int:
	return Game.ref.data.energy

## Производство энергия за нажатия
func click_energy() -> void:
	var quantity_added: int = 1
	quantity_added += Game.ref.data.up_c_1_amount
	
	create_energy(quantity_added)

## Добавляет quantity энергии к числу хранимой
func create_energy(quantity : int) -> void:
	Game.ref.data.energy += quantity
	energy_created.emit()
	
	if Game.ref.data.energy >= energy_for_next_str:
		HandlerSTR.ref.create_st_r(1)
		n += 1
		Game.ref.data.str_from_energy_gained = n
		energy_for_next_str = 1000 * int(pow(10, n))


## Try to consume some quantity of energy from stored
func consume_energy(quantity : int) -> Error:
	if quantity > Game.ref.data.energy:
		return Error.FAILED
	
	Game.ref.data.energy -= quantity
	energy_consumed.emit()
	
	return Error.OK

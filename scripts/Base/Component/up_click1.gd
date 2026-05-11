class_name UpClick1
extends Node
## Upgrade for click number 1. Increase energy from clicks.

##
signal bought


## How many already bought
var amount : int = 0
## Name of upgrade
var title : String = "Click Upgrade"
## What it does
var description : String
## How much for first one
var base_cost : int = 10
## How much for one
var cost : int = 1


func _init() -> void:
	amount = Game.ref.data.up_c_1_amount
	Calculate_cost()
	description = getDescription()
	


## Returns upgrade description and cost
func getDescription() -> String:
	var desc : String = "Increases the amount of energy created by Clicking."
	desc += "\nEffects : +1 click"
	desc += "\nCost : %s" %cost
	
	return desc


## Returns how much for one
func Calculate_cost() -> void:
	cost = base_cost + 2 * base_cost * int(amount**1.5)


func is_afordable() -> bool:
	if HandlerEnergy.ref.energy() >= cost:
		return true
	
	return false

func buy_one() -> void:
	if not HandlerEnergy.ref.consume_energy(cost):
		amount += 1
		Game.ref.data.up_c_1_amount = amount
		
		Calculate_cost()
		description = getDescription()
		
		bought.emit()
	

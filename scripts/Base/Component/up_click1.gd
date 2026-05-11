class_name UpClick1
extends Upgrade
## Upgrade for click number 1. Increase energy from clicks.


func _init() -> void:
	amount = Game.ref.data.up_c_1_amount
	title = "Clicker Upgrade"
	base_cost = 5
	calculate_cost()
	description = get_description()
	


## Returns upgrade description and cost
func get_description() -> String:
	var desc : String = "Increases the amount of energy created by Clicking."
	desc += "\nEffects : +1 click"
	desc += "\nCost : %s" %cost
	
	return desc


## Returns how much for one
func calculate_cost() -> void:
	cost = base_cost + 2 * base_cost * int(amount**1.5)


func is_afordable() -> bool:
	if HandlerEnergy.ref.energy() >= cost:
		return true
	
	return false

func buy_one() -> void:
	if not HandlerEnergy.ref.consume_energy(cost):
		amount += 1
		Game.ref.data.up_c_1_amount = amount
		
		calculate_cost()
		description = get_description()
		
		bought.emit()
	

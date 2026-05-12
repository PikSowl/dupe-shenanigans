class_name STF1CoalPlant
extends Upgrade
## Unlocks Coal Plant - passive energy generator.


func _init() -> void:
	is_forged = Game.ref.data.stf.stf_1_forged
	amount = 0
	title = "Coal Plant"
	base_cost = 3
	calculate_cost()
	description = get_description()


## Returns upgrade description and cost
func get_description() -> String:
	var desc : String = "Your first passive source of energy."
	desc += "\nEffects : +1 energy/s"
	desc += "\nCost in STR: %s" %cost
	
	return desc


## Returns how much for this one
func calculate_cost() -> void:
	cost = base_cost


func is_afordable() -> bool:
	if is_forged:
		return false
	
	if HandlerSTR.ref.st_r() >= cost:
		return true
	
	return false


func buy_one() -> void:
	if not HandlerSTR.ref.consume_st_r(cost):
		is_forged = true
		amount+=1
		Game.ref.data.stf.stf_1_forged = is_forged

		bought.emit()
		HandlerSTForge.ref.get_forged.emit(self)

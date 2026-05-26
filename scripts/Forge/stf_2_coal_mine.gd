class_name STF2CoalMine
extends Upgrade
## Unlocks Coal Mine - improves Coal Plant.


var max_times_forged : int = 5


func _init() -> void:
	times_forged = Game.ref.data.stf.stf_2_times_forged
	title = "Coal Mine"
	base_cost = 5
	calculate_cost()
	description = get_description()


## Returns upgrade description and cost
func get_description() -> String:
	var desc : String = "Improves coal based generation"
	desc += "\nEffects: *2 energy/s from coal"
	desc += "\nCost in STR: %s" %cost
	
	return desc


## Returns how much for this one
func calculate_cost() -> void:
	cost = base_cost + int(pow(base_cost, times_forged))


func is_afordable() -> bool:
	if times_forged >= max_times_forged:
		return false
	
	if HandlerSTR.ref.st_r() >= cost:
		return true
	
	return false


func buy_one() -> void:
	if not HandlerSTR.ref.consume_st_r(cost):
		times_forged += 1
		Game.ref.data.stf.stf_2_times_forged = times_forged
		print("ba")
		
		bought.emit()
		HandlerSTForge.ref.get_forged.emit()

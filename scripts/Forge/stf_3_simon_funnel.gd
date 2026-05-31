class_name STF3SimomFunnel
extends Upgrade
## Unlocks Simom mini-game.


func _init() -> void:
	is_forged = Game.ref.data.stf.stf_3_forged
	times_forged = 0
	title = "Воронка Саймона"
	base_cost = 1
	calculate_cost()
	description = get_description()


## Returns upgrade description and cost
func get_description() -> String:
	var desc : String = "Саймон был бы рад этому!"
	desc += "\nЭффект: Открывает мини-игру Саймон"
	desc += "\nСтоимость в ЗВД: %s" %cost
	
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
		times_forged+=1
		Game.ref.data.stf.stf_3_forged = is_forged

		bought.emit()
		HandlerSTForge.ref.get_forged.emit()

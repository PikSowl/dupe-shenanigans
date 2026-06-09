class_name STF1CoalPlant
extends Upgrade
## Unlocks Coal Plant - passive energy generator.


func _init() -> void:
	is_forged = Game.ref.data.stf.stf_1_forged
	times_forged = 0
	title = "Угольный генератор"
	base_cost = 2
	calculate_cost()
	description = get_description()


## Возращает описание улучшения и его стоимость
func get_description() -> String:
	var desc : String = "Твой первый источник пасивной энергии."
	desc += "\nЭффект: +1 энергия/с"
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
		Game.ref.data.stf.stf_1_forged = is_forged

		bought.emit()
		HandlerSTForge.ref.get_forged.emit()

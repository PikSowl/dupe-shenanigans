class_name STF4FuncQuizFunnel
extends Upgrade
## Unlocks Func Quiz mini-game.


func _init() -> void:
	is_forged = Game.ref.data.stf.stf_4_forged
	times_forged = int(Game.ref.data.stf.stf_4_forged)
	title = "Воронка Функ Вик"
	base_cost = 0
	calculate_cost()
	description = get_description()


## Returns upgrade description and cost
func get_description() -> String:
	var desc : String = "Хорошо ли ты изучил графики функций?"
	desc += "\nЭффект: Открывает мини-игру Функ Вик"
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
		Game.ref.data.stf.stf_4_forged = is_forged

		bought.emit()
		HandlerSTForge.ref.get_forged.emit()

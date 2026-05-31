class_name ComponentUpgrade
extends Control
## Component displaying an upgrade.

@export var label_title : Label

@export var label_description : RichTextLabel

@export var buy_button : Button

## Upgrade to display
var upgrade : Upgrade


func  _ready() -> void:
	if not upgrade:
		upgrade = UpClick1.new()
	
	update_label_title()
	update_label_description()
	update_button()
	
	HandlerEnergy.ref.energy_created.connect(update_button)
	HandlerEnergy.ref.energy_consumed.connect(update_button)
	HandlerSTR.ref.st_r_created.connect(update_button)
	HandlerSTR.ref.st_r_consumed.connect(update_button)
	
	
	upgrade.bought.connect(update_label_title)
	upgrade.bought.connect(update_label_description)
	upgrade.bought.connect(update_button)



func update_label_title() -> void:
	var text : String = upgrade.title + " (%s)" %upgrade.times_forged
	label_title.text = text


func update_label_description() -> void:
	var text : String = upgrade.description
	label_description.text = text


## Updates button availability
func update_button() -> void:
	if upgrade.is_afordable():
		buy_button.disabled = false
		return
	
	buy_button.disabled = true

## Вызывается по нажатию кнопки Купить
func _on_purchase_pressed() -> void:
	upgrade.buy_one()

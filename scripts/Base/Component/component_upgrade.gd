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
	
	upgrade.bought.connect(update_label_title)
	upgrade.bought.connect(update_label_description)
	upgrade.bought.connect(update_button)


func update_label_title() -> void:
	var text : String = upgrade.title + " (%s)" %upgrade.amount
	label_title.text = text


func update_label_description() -> void:
	var text : String = upgrade.description + " (%s)" %upgrade.amount
	label_description.text = text


## Updates button availability
func update_button(_quantity : int = -1) -> void:
	if upgrade.is_afordable():
		buy_button.disabled = false
		return
	
	buy_button.disabled = true


func _on_purchase_pressed() -> void:
	upgrade.buy_one()

extends TextureButton

@onready var price: Label = $HBoxContainer/Price
@onready var quantity: Label = $Quantity
@onready var name_label: Label = $NameLabel

@export var troop_data: TroopData # Should be set in init

func _ready() -> void:
	name_label.text = str(troop_data.troop_name)
	price.text = str(troop_data.blocks_cost)
	quantity.text = "x" + str(troop_data.troop_quantity)
	quantity.visible = troop_data.troop_quantity > 1

func purchase () -> void:
	if PlayerStatus.blocks < troop_data.blocks_cost: return
	PlayerStatus.blocks -= troop_data.blocks_cost
	SignalBus.emit_blocks_changed()
	
	for i in troop_data.troop_quantity:
		PlayerStatus.stored_troops.append(troop_data.troop)
	
	queue_free()

func _on_pressed() -> void:
	purchase()

extends CanvasLayer
@onready var error_modal = $"../ErrorModal"
@onready var item_grid = $ItemList/ItemPnl/ItemGrid

func _ready():
	var user_inventory : Dictionary = Game.get_user_inventory_local()
	for item in user_inventory:
		if user_inventory[item] <= 0:
			continue
		var item_scene : Control  = load("res://scenes/navigation/store_inventory/inventory/inventory_item.tscn").instantiate()
		item_grid.add_child(item_scene)
		var item_name : Label  = item_scene.get_node('MarginContainer/ItemPnl/ItemNameLbl')
		var image : TextureRect  = item_scene.get_node('MarginContainer/ItemPnl/DetailVbox/ItemImg')
		var quantity : Label  = item_scene.get_node('MarginContainer/ItemPnl/DetailVbox/ItemImg/QuantityLbl')
		quantity.set_text("x" + str(user_inventory[item]))
		item_name.set_text(Game.name_logic(item))
		image.set_texture(Game.texture_logic(item))
#	for item in child_item_array:
#		var purchase_details: Dictionary = {"bundle_id" = int(item.get_node('BundleId').get_text()),
#											"item_name" = item.get_node("MarginContainer/StoreItemPnl/ItemNameLbl").get_text(),
#											"quantity" = int(item.get_node("MarginContainer/StoreItemPnl/DetailVbox/ItemImg/QuantityLbl").get_text()),
#											"price" = int(item.get_node("MarginContainer/StoreItemPnl/DetailVbox/PriceLbl").get_text())}
#		item.get_node("StoreItem").connect("pressed", purchase_item.bind(purchase_details))
##		item.get_node("StoreItem").connect("pressed", purchase_item.bind(item))
#	store_btn.pressed.connect(modal_btn_pressed.bind(store_scene))

#func purchase_item(purchase_details: Dictionary):
##	print(str(Game.user_inventory['coin']) + str(purchase_details['price']))
#	if int(Game.user_inventory['coin']) < purchase_details['price']:
#		print("insuff")
#		return
#	Game.user_inventory['coin'] = int(Game.user_inventory['coin']) - purchase_details['price']
#	Game.user_inventory['coin_timestamp'] = Time.get_unix_time_from_system()
#	var item_name : String = Game.reverse_name_logic(purchase_details['item_name'])
#	Game.user_inventory[item_name] = int(Game.user_inventory[item_name]) + purchase_details['quantity']
#	Game.user_inventory[item_name + '_timestamp'] = Time.get_unix_time_from_system()
#	Game.update_local_save()
#	await Game.query_update()
#	Game.record_purchase(purchase_details['bundle_id'])
#	print(Game.user_inventory)
#



func _on_close_button_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	queue_free()

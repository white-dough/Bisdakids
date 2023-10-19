extends CanvasLayer
@onready var error_modal = $"../ErrorModal"

func _ready():
	Game.check_is_connected_internet()
	await Game.http_request.request_completed
	var internet = true if Game.is_connected_to_internet else false
	if !internet:
		queue_free()
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("NO INTERNET CONNECTION")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Please fix your internet connection and try again")
		error_modal.visible = true
	###
	var child_item_array : Array = []
	PhpRequest.store_query()
	await PhpRequest.http_request.request_completed
	for i in PhpRequest.clean_response.size():
		var item_scene : Control  = load("res://scenes/navigation/store_inventory/store/store_item_pnl.tscn").instantiate()
		child_item_array.append(item_scene)
		$Store/ItemList/ItemPnl/ItemGrid.add_child(child_item_array[i])
		var price : Label  = child_item_array[i].get_node('MarginContainer/StoreItemPnl/DetailVbox/PriceLbl')
		var image : TextureRect  = child_item_array[i].get_node('MarginContainer/StoreItemPnl/DetailVbox/ItemImg')
		var quantity : Label  = child_item_array[i].get_node('MarginContainer/StoreItemPnl/DetailVbox/ItemImg/QuantityLbl')
		var item_name : Label  = child_item_array[i].get_node('MarginContainer/StoreItemPnl/ItemNameLbl')
		var bundle_id : Label  = child_item_array[i].get_node('BundleId')
		bundle_id.set_text(str(PhpRequest.clean_response[i]['bundle_id']))
		price.set_text(str(PhpRequest.clean_response[i]['price_coin']) + " coins")
		quantity.set_text("x" + str(PhpRequest.clean_response[i]['bundle_quantity']))
		item_name.set_text(Game.name_logic(PhpRequest.clean_response[i]['item_name']))
		image.set_texture(Game.texture_logic((PhpRequest.clean_response[i]['item_name'])))
	for item in child_item_array:
		var purchase_details: Dictionary = {"bundle_id" = int(item.get_node('BundleId').get_text()),
											"item_name" = item.get_node("MarginContainer/StoreItemPnl/ItemNameLbl").get_text(),
											"quantity" = int(item.get_node("MarginContainer/StoreItemPnl/DetailVbox/ItemImg/QuantityLbl").get_text()),
											"price" = int(item.get_node("MarginContainer/StoreItemPnl/DetailVbox/PriceLbl").get_text())}
		item.get_node("StoreItem").connect("pressed", purchase_item.bind(purchase_details))
#		item.get_node("StoreItem").connect("pressed", purchase_item.bind(item))
#	store_btn.pressed.connect(modal_btn_pressed.bind(store_scene))

func purchase_item(purchase_details: Dictionary):
#	print(str(Game.user_inventory['coin']) + str(purchase_details['price']))
	if int(Game.user_inventory['coin']) < purchase_details['price']:
		print("insuff")
		return
	Game.user_inventory['coin'] = int(Game.user_inventory['coin']) - purchase_details['price']
	Game.user_inventory['coin_timestamp'] = Time.get_unix_time_from_system()
	var item_name : String = Game.reverse_name_logic(purchase_details['item_name'])
	Game.user_inventory[item_name] = int(Game.user_inventory[item_name]) + purchase_details['quantity']
	Game.user_inventory[item_name + '_timestamp'] = Time.get_unix_time_from_system()
	Game.update_local_save()
	await Game.query_update()
	Game.record_purchase(purchase_details['bundle_id'])
	print(Game.user_inventory)



func _on_close_btn_pressed():
	queue_free()

extends CanvasLayer
@onready var error_modal = $"../ErrorModal"

func _ready():
	Game.check_is_connected_internet()
	await Game.http_request.request_completed
	var internet = true if Game.is_connected_to_internet else false
	if !internet:
		queue_free()
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALAY KONEKSYON SA INTERNET!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Palihug ayo-a ang imong koneksiyon sa internet ug suwayi pag-usab.")
		error_modal.visible = true
	###
	var child_item_array : Array = []
	PhpRequest.store_query()
	await PhpRequest.http_request.request_completed
	if PhpRequest.api_no_error:
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
			item.get_node("StoreItem").connect("pressed", purchase_attempt.bind(purchase_details))
	else:
		queue_free()
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorLbl".set_text("WALAY TUBAG GIKAN SA SERBER!")
		$"../ErrorModal/ErrorModalPnl/ErrorContentVbox/ErrorDescLbl".set_text("Palihug pagpailob kanamo samtang amo kinang giayo ang problema sa serber.")
		error_modal.visible = true
#		item.get_node("StoreItem").connect("pressed", purchase_item.bind(item))
#	store_btn.pressed.connect(modal_btn_pressed.bind(store_scene))
func purchase_attempt(purchase_details: Dictionary):
	if int(Game.user_inventory['coin']) < purchase_details['price']:
		Audio.play_sfx(Audio.close_btn_sfx)
		$insufficient_coins.show()
		return
	$purchase_confirm.show()
	if $purchase_confirm/ModalPanel2/Content_Container/yes_btn.is_connected("pressed", purchase_item.bind(purchase_details)):
		$purchase_confirm/ModalPanel2/Content_Container/yes_btn.pressed.disconnect(purchase_item.bind(purchase_details))
	$purchase_confirm/ModalPanel2/Content_Container/yes_btn.pressed.connect(purchase_item.bind(purchase_details))

func purchase_item(purchase_details: Dictionary):	
	$purchase_confirm.hide()
#	print(str(Game.user_inventory['coin']) + str(purchase_details['price']))	
	Audio.play_sfx(Audio.normal_btn_sfx)
	Game.user_inventory['coin'] = int(Game.user_inventory['coin']) - purchase_details['price']
	Game.user_inventory['coin_timestamp'] = Time.get_unix_time_from_system()
	var item_name : String = Game.reverse_name_logic(purchase_details['item_name'])
	Game.user_inventory[item_name] = int(Game.user_inventory[item_name]) + purchase_details['quantity']
	Game.user_inventory[item_name + '_timestamp'] = Time.get_unix_time_from_system()
#	print(Game.user_inventory)
	await Game.sync_data()
	Game.record_purchase(purchase_details['bundle_id'])
	Game.update_local_save()
#	print(Game.user_inventory)

func _on_close_btn_pressed():
	Audio.play_sfx(Audio.close_btn_sfx)
	queue_free()

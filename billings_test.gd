extends Control
var payment
var itemToken
# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.has_singleton("GodotGooglePlayBilling"):
		payment = Engine.get_singleton("GodotGooglePlayBilling")
#		payment.billing_resume.connect(_on_billing_resume) # No params
		payment.connected.connect(_on_connected) # No params
#		payment.disconnected.connect(_on_disconnected) # No params
#		payment.connect_error.connect(_on_connect_error) # Response ID (int), Debug message (string)
#		payment.price_change_acknowledged.connect(_on_price_acknowledged) # Response ID (int)
		payment.purchases_updated.connect(_on_purchases_updated) # Purchases (Dictionary[])
#		payment.purchase_error.connect(_on_purchase_error) # Response ID (int), Debug message (string)
#		payment.product_details_query_completed.connect(_on_product_details_query_completed) # Products (Dictionary[])
#		payment.product_details_query_error.connect(_on_product_details_query_error) # Response ID (int), Debug message (string), Queried SKUs (string[])
		payment.purchase_acknowledged.connect(_on_purchase_acknowledged) # Purchase token (string)
#		payment.purchase_acknowledgement_error.connect(_on_purchase_acknowledgement_error) # Response ID (int), Debug message (string), Purchase token (string)
		payment.purchase_consumed.connect(_on_purchase_consumed) # Purchase token (string)
#		payment.purchase_consumption_error.connect(_on_purchase_consumption_error) # Response ID (int), Debug message (string), Purchase token (string)
#		payment.query_purchases_response.connect(_on_query_purchases_response) # Purchases (Dictionary[])
		payment.startConnection()
	else:	
		print("Android IAP support is not enabled. Make sure you have enabled 'Custom Build' and the GodotGooglePlayBilling plugin in your Android export settings! IAP will not work.")

func _on_connected():
	payment.querySkuDetails(['testSKU'], "inapp")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_purchases_updated(items):
	for item in items:
		if !item.is_acknowledged:
			print("acknowledge purchases" + item.purchase_token)
			payment.acknowledgePurchase(item.purchase_token)
	if items.size() > 0:
		itemToken = items[items.size() - 1].purchase_token
			
func _on_purchase_acknowledged(token):
	print("purchase was acknowledged" + token)

func _on_purchase_consumed(token):
	print("Item was consumed" + token)
func _on_buy_button_down():
	var response = payment.purchase("testSKU")
	print("Purchase attempt: " + response.status)
	if response.status != OK:
		print("error purchasing item")


func _on_use_button_down():
	if itemToken == null:
		print("Error buy this first")
	else:
		print("consuming item")
		payment.consumePurchase(itemToken)

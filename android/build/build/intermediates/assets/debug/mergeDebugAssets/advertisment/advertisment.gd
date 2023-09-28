extends Node

var ad_view : AdView
var ad_listener := AdListener.new()
var adPosition := AdPosition.Values.TOP

# Called when the node enters the scene tree for the first time.
func _ready():
	if ad_view:
		ad_view.destroy() #always try to destroy the ad_view if won't use anymore to clear memory
	ad_view.ad_listener = ad_listener
	var ad_request := AdRequest.new()
	var ad_colony_mediation_extras := AdColonyMediationExtras.new()
	ad_colony_mediation_extras.show_post_popup = false
	ad_colony_mediation_extras.show_pre_popup = true
	ad_request.mediation_extras.append(ad_colony_mediation_extras)
	ad_request.keywords.append("21313")
	ad_request.extras["ID"] = "value"
	ad_view.load_ad(ad_request)
	ad_view.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

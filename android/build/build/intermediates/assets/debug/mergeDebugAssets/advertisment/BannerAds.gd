extends Node

var ad_view : AdView
var adPosition := AdPosition.Values.BOTTOM
var ad_listener := AdListener.new()

func _ready() -> void:
	ad_listener.on_ad_failed_to_load = _on_ad_failed_to_load
	ad_listener.on_ad_loaded = _on_ad_loaded
	load_banner()

func load_banner() -> void:
	if ad_view:
		ad_view.destroy() #always try to destroy the ad_view if won't use anymore to clear memory
	var ad_size := AdSize.new(480, 32)
	ad_view = AdView.new("ca-app-pub-3940256099942544/2934735716", ad_size, adPosition)
	ad_view.ad_listener = ad_listener
	var ad_request := AdRequest.new()
	ad_view.load_ad(ad_request)

func destroy_banner() -> void:
	if ad_view:
		ad_view.destroy()
		ad_view = null

func _on_ad_failed_to_load(load_ad_error : LoadAdError) -> void:
	print("_on_ad_failed_to_load: " + load_ad_error.message)

func _on_ad_loaded() -> void:
	print("_on_ad_loaded")
	

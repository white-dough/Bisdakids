extends Node2D

var ad_view : AdView
var adPosition := AdPosition.Values.BOTTOM

func _ready():
	#The initializate needs to be done only once, ideally at app launch.
	MobileAds.initialize()
#	load_show_banner()

func load_show_banner():
	if ad_view:
		ad_view.destroy() #always try to destroy the ad_view if won't use anymore to clear memory
	var ad_size := AdSize.new(480, 32)
	ad_view = AdView.new("ca-app-pub-3940256099942544/2934735716", ad_size, adPosition)
	var ad_request := AdRequest.new()
	ad_view.load_ad(ad_request)
	ad_view.show()

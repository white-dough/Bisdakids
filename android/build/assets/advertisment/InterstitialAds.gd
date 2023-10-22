extends Node

var interstitial_ad_declared : InterstitialAd
var interstitial_ad_load_callback := InterstitialAdLoadCallback.new()
var full_screen_content_callback := FullScreenContentCallback.new()

func _ready():
	interstitial_ad_load_callback.on_ad_failed_to_load = on_interstitial_ad_failed_to_load
	interstitial_ad_load_callback.on_ad_loaded = on_interstitial_ad_loaded
	full_screen_content_callback.on_ad_dismissed_full_screen_content = func() -> void:
		print("on_ad_dismissed_full_screen_content")
		destroy()
	full_screen_content_callback.on_ad_showed_full_screen_content = func() -> void:
		print("on_ad_showed_full_screen_content")

func load_show_interstitial():
	InterstitialAdLoader.new().load("ca-app-pub-3940256099942544/1033173712", AdRequest.new(), interstitial_ad_load_callback)

func on_interstitial_ad_failed_to_load(adError : LoadAdError) -> void:
	print(adError.message)
	
func on_interstitial_ad_loaded(interstitial_ad : InterstitialAd) -> void:
	print("interstitial ad loaded" + str(interstitial_ad._uid))
	interstitial_ad.full_screen_content_callback = full_screen_content_callback
	interstitial_ad_declared = interstitial_ad
	if interstitial_ad_declared:
		interstitial_ad_declared.show()

func _on_destroy_pressed():
	destroy()

func destroy():
	if interstitial_ad_declared:
		interstitial_ad_declared.destroy()
		interstitial_ad_declared = null #need to load again

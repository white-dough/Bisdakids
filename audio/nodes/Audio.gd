extends Node

@onready var bgm_node: AudioStreamPlayer = $MainMenuBGM
@onready var sfx_node: AudioStreamPlayer = $SFX
@onready var object_sfx_node: AudioStreamPlayer = $Object

#background musics
@onready var main_bgm: AudioStream = preload("res://audio/assets/bgm/main_bgm.mp3")
@onready var levels_bgm: AudioStream = preload("res://audio/assets/bgm/levels_bgm.wav")
@onready var boss_bgm: AudioStream = preload("res://audio/assets/bgm/boss_battle_bgm.wav")

#clicks
@onready var wood_btn_sfx: AudioStream = preload("res://audio/assets/sfx/wood_click_sfx.mp3")
@onready var close_btn_sfx: AudioStream = preload("res://audio/assets/sfx/close_button_sfx.mp3")
@onready var normal_btn_sfx: AudioStream = preload("res://audio/assets/sfx/button_clicked_sfx.mp3")
@onready var level_btn_sfx: AudioStream = preload("res://audio/assets/sfx/levels_btn_sfx.mp3")

#effects
@onready var hint_sfx: AudioStream = preload("res://audio/assets/sfx/hint_sfx.mp3")
@onready var incorrect_sfx: AudioStream = preload("res://audio/assets/sfx/incorrect_sfx.mp3")
@onready var freeze_sfx: AudioStream = preload("res://audio/assets/sfx/freeze_sfx.wav")
@onready var correct_sfx: AudioStream = preload("res://audio/assets/sfx/object_found_sfx.mp3")
@onready var book_flip_sfx: AudioStream = preload("res://audio/assets/sfx/word_def_sfx.mp3")

#result sfx
@onready var success_sfx: AudioStream = preload("res://audio/assets/sfx/victory_sfx.wav")
@onready var fail_sfx: AudioStream = preload("res://audio/assets/sfx/failed_sfx.wav")
@onready var dt_claim_sfx: AudioStream = preload("res://audio/assets/sfx/claim_reward_dt_sfx.wav")

# objects 
@onready var Angkla: AudioStream = preload("res://audio/objects-voice-overs/Angkla.wav")
@onready var Antipara: AudioStream = preload("res://audio/objects-voice-overs/Antipara.wav")
@onready var Atsa: AudioStream = preload("res://audio/objects-voice-overs/Atsa.wav")
@onready var Bag: AudioStream = preload("res://audio/objects-voice-overs/Bag.wav")
@onready var Bahandi: AudioStream = preload("res://audio/objects-voice-overs/Bahandi.wav")
@onready var Balde: AudioStream = preload("res://audio/objects-voice-overs/Balde.wav")
@onready var Banig: AudioStream = preload("res://audio/objects-voice-overs/Banig.wav")
@onready var Baol: AudioStream = preload("res://audio/objects-voice-overs/Baol.wav")
@onready var Barel: AudioStream = preload("res://audio/objects-voice-overs/Barel.wav")
@onready var Barko: AudioStream = preload("res://audio/objects-voice-overs/Barko.wav")
@onready var Baso: AudioStream = preload("res://audio/objects-voice-overs/Baso.wav")
@onready var Bisikleta: AudioStream = preload("res://audio/objects-voice-overs/Bisikleta.wav")
@onready var Bituon: AudioStream = preload("res://audio/objects-voice-overs/Bituon.wav")
@onready var Bola: AudioStream = preload("res://audio/objects-voice-overs/Bola.wav")
@onready var Bomba: AudioStream = preload("res://audio/objects-voice-overs/Bomba.wav")
@onready var Botas: AudioStream = preload("res://audio/objects-voice-overs/Botas.wav")
@onready var Botilya: AudioStream = preload("res://audio/objects-voice-overs/Botilya.wav")
@onready var Bukag: AudioStream = preload("res://audio/objects-voice-overs/Bukag.wav")
@onready var Bulsita: AudioStream = preload("res://audio/objects-voice-overs/Bulsita.wav")
@onready var Bungo: AudioStream = preload("res://audio/objects-voice-overs/Bungo.wav")
@onready var Duyan: AudioStream = preload("res://audio/objects-voice-overs/Duyan.wav")
@onready var Eroplano: AudioStream = preload("res://audio/objects-voice-overs/Eroplano.wav")
@onready var Espada: AudioStream = preload("res://audio/objects-voice-overs/Espada.wav")
@onready var Globo: AudioStream = preload("res://audio/objects-voice-overs/Globo.wav")
@onready var Gwantes: AudioStream = preload("res://audio/objects-voice-overs/Gwantes.wav")
@onready var Hagdanan: AudioStream = preload("res://audio/objects-voice-overs/Hagdanan.wav")
@onready var Kaban: AudioStream = preload("res://audio/objects-voice-overs/Kaban.wav")
@onready var Kadena: AudioStream = preload("res://audio/objects-voice-overs/Kadena.wav")
@onready var Kahig: AudioStream = preload("res://audio/objects-voice-overs/Kahig.wav")
@onready var Kalo: AudioStream = preload("res://audio/objects-voice-overs/Kalo.wav")
@onready var Kandila: AudioStream = preload("res://audio/objects-voice-overs/Kandila.wav")
@onready var Karitilya: AudioStream = preload("res://audio/objects-voice-overs/Karitilya.wav")
@onready var Kariton: AudioStream = preload("res://audio/objects-voice-overs/Kariton.wav")
@onready var Karton: AudioStream = preload("res://audio/objects-voice-overs/Karton.wav")
@onready var Katolganan: AudioStream = preload("res://audio/objects-voice-overs/Katolganan.wav")
@onready var Kodak: AudioStream = preload("res://audio/objects-voice-overs/Kodak.wav")
@onready var Kompas: AudioStream = preload("res://audio/objects-voice-overs/Kompas.wav")
@onready var Korona: AudioStream = preload("res://audio/objects-voice-overs/Korona.wav")
@onready var Kuhit: AudioStream = preload("res://audio/objects-voice-overs/Kuhit.wav")
@onready var Kutsara: AudioStream = preload("res://audio/objects-voice-overs/Kutsara.wav")
@onready var Kutsilyo: AudioStream = preload("res://audio/objects-voice-overs/Kutsilyo.wav")
@onready var Kuwadro: AudioStream = preload("res://audio/objects-voice-overs/Kuwadro.wav")
@onready var Lamesa: AudioStream = preload("res://audio/objects-voice-overs/Lamesa.wav")
@onready var Lampara: AudioStream = preload("res://audio/objects-voice-overs/Lampara.wav")
@onready var Largabista: AudioStream = preload("res://audio/objects-voice-overs/Largabista.wav")
@onready var Ligid: AudioStream = preload("res://audio/objects-voice-overs/Ligid.wav")
@onready var Lingkuranan: AudioStream = preload("res://audio/objects-voice-overs/Lingkuranan.wav")
@onready var Lumay: AudioStream = preload("res://audio/objects-voice-overs/Lumay.wav")
@onready var Lutuanan: AudioStream = preload("res://audio/objects-voice-overs/Lutuanan.wav")
@onready var Maleta: AudioStream = preload("res://audio/objects-voice-overs/Maleta.wav")
@onready var Mansanas: AudioStream = preload("res://audio/objects-voice-overs/Mansanas.wav")
@onready var Mapa: AudioStream = preload("res://audio/objects-voice-overs/Mapa.wav")
@onready var Orasan: AudioStream = preload("res://audio/objects-voice-overs/Orasan.wav")
@onready var Pakwan: AudioStream = preload("res://audio/objects-voice-overs/Pakwan.wav")
@onready var Pala: AudioStream = preload("res://audio/objects-voice-overs/Pala.wav")
@onready var Pana: AudioStream = preload("res://audio/objects-voice-overs/Pana.wav")
@onready var Pangtabas: AudioStream = preload("res://audio/objects-voice-overs/Pangtabas.wav")
@onready var Papel: AudioStream = preload("res://audio/objects-voice-overs/Papel.wav")
@onready var Payong: AudioStream = preload("res://audio/objects-voice-overs/Payong.wav")
@onready var Pigurin: AudioStream = preload("res://audio/objects-voice-overs/Pigurin.wav")
@onready var Pluma: AudioStream = preload("res://audio/objects-voice-overs/Pluma.wav")
@onready var Plurira: AudioStream = preload("res://audio/objects-voice-overs/Plurira.wav")
@onready var Regadera: AudioStream = preload("res://audio/objects-voice-overs/Regadera.wav")
@onready var Regalo: AudioStream = preload("res://audio/objects-voice-overs/Regalo.wav")
@onready var Sako: AudioStream = preload("res://audio/objects-voice-overs/Sako.wav")
@onready var Salag: AudioStream = preload("res://audio/objects-voice-overs/Salag.wav")
@onready var Salbabida: AudioStream = preload("res://audio/objects-voice-overs/Salbabida.wav")
@onready var Samin: AudioStream = preload("res://audio/objects-voice-overs/Samin.wav")
@onready var Sanggot: AudioStream = preload("res://audio/objects-voice-overs/Sanggot.wav")
@onready var Sapatos: AudioStream = preload("res://audio/objects-voice-overs/Sapatos.wav")
@onready var Sigarilyo: AudioStream = preload("res://audio/objects-voice-overs/Sigarilyo.wav")
@onready var Sikoy: AudioStream = preload("res://audio/objects-voice-overs/Sikoy.wav")
@onready var Silhig: AudioStream = preload("res://audio/objects-voice-overs/Silhig.wav")
@onready var Sinsilyo: AudioStream = preload("res://audio/objects-voice-overs/Sinsilyo.wav")
@onready var Sista: AudioStream = preload("res://audio/objects-voice-overs/Sista.wav")
@onready var Tawo_tawo: AudioStream = preload("res://audio/objects-voice-overs/Tawo-tawo.wav")
@onready var Teleskopyo: AudioStream = preload("res://audio/objects-voice-overs/Teleskopyo.wav")
@onready var Tibud: AudioStream = preload("res://audio/objects-voice-overs/Tibud.wav")
@onready var Timaan: AudioStream = preload("res://audio/objects-voice-overs/Timaan.wav")
@onready var Timbangan: AudioStream = preload("res://audio/objects-voice-overs/Timbangan.wav")
@onready var Tinidor: AudioStream = preload("res://audio/objects-voice-overs/Tinidor.wav")
@onready var Tirador: AudioStream = preload("res://audio/objects-voice-overs/Tirador.wav")
@onready var Tolda: AudioStream = preload("res://audio/objects-voice-overs/Tolda.wav")
@onready var Tropeyo: AudioStream = preload("res://audio/objects-voice-overs/Tropeyo.wav")
@onready var Troso: AudioStream = preload("res://audio/objects-voice-overs/Troso.wav")
@onready var Tsarira: AudioStream = preload("res://audio/objects-voice-overs/Tsarira.wav")
@onready var Tsinelas: AudioStream = preload("res://audio/objects-voice-overs/Tsinelas.wav")
@onready var Yawi: AudioStream = preload("res://audio/objects-voice-overs/Yawi.wav")
@onready var object_audio: Dictionary = {
	"Angkla": Audio.Angkla,
	"Antipara": Audio.Antipara,
	"Atsa": Audio.Atsa,
	"Bag": Audio.Bag,
	"Bahandi": Audio.Bahandi,
	"Balde": Audio.Balde,
	"Banig": Audio.Banig,
	"Baol": Audio.Baol,
	"Barel": Audio.Barel,
	"Barko": Audio.Barko,
	"Baso": Audio.Baso,
	"Bisikleta": Audio.Bisikleta,
	"Bituon": Audio.Bituon,
	"Bola": Audio.Bola,
	"Bomba": Audio.Bomba,
	"Botas": Audio.Botas,
	"Botilya": Audio.Botilya,
	"Bukag": Audio.Bukag,
	"Bulsita": Audio.Bulsita,
	"Bungo": Audio.Bungo,
	"Duyan": Audio.Duyan,
	"Eroplano": Audio.Eroplano,
	"Espada": Audio.Espada,
	"Globo": Audio.Globo,
	"Gwantes": Audio.Gwantes,
	"Hagdanan": Audio.Hagdanan,
	"Kaban": Audio.Kaban,
	"Kadena": Audio.Kadena,
	"Kahig": Audio.Kahig,
	"Kalo": Audio.Kalo,
	"Kandila": Audio.Kandila,
	"Karitilya": Audio.Karitilya,
	"Kariton": Audio.Kariton,
	"Karton": Audio.Karton,
	"Katulganan": Audio.Katolganan,
	"Kodak": Audio.Kodak,
	"Kumpas": Audio.Kompas,
	"Korona": Audio.Korona,
	"Kuhit": Audio.Kuhit,
	"Kutsara": Audio.Kutsara,
	"Kutsilyo": Audio.Kutsilyo,
	"Kuwadro": Audio.Kuwadro,
	"Lamesa": Audio.Lamesa,
	"Lampara": Audio.Lampara,
	"Largabista": Audio.Largabista,
	"Ligid": Audio.Ligid,
	"Lingkuranan": Audio.Lingkuranan,
	"Lumay": Audio.Lumay,
	"Lutuanan": Audio.Lutuanan,
	"Maleta": Audio.Maleta,
	"Mansanas": Audio.Mansanas,
	"Mapa": Audio.Mapa,
	"Orasan": Audio.Orasan,
	"Pakwan": Audio.Pakwan,
	"Pala": Audio.Pala,
	"Pana": Audio.Pana,
	"Pangtabas": Audio.Pangtabas,
	"Papel": Audio.Papel,
	"Payong": Audio.Payong,
	"Pigurin": Audio.Pigurin,
	"Pluma": Audio.Pluma,
	"Plurira": Audio.Plurira,
	"Regadera": Audio.Regadera,
	"Regalo": Audio.Regalo,
	"Sako": Audio.Sako,
	"Salag": Audio.Salag,
	"Salbabida": Audio.Salbabida,
	"Samin": Audio.Samin,
	"Sanggot": Audio.Sanggot,
	"Sapatos": Audio.Sapatos,
	"Sigarilyo": Audio.Sigarilyo,
	"Sikoy": Audio.Sikoy,
	"Silhig": Audio.Silhig,
	"Sinsilyo": Audio.Sinsilyo,
	"Sista": Audio.Sista,
	"Tawo-tawo": Audio.Tawo_tawo,
	"Teleskopyo": Audio.Teleskopyo,
	"Tibod": Audio.Tibud,
	"Timaan": Audio.Timaan,
	"Timbangan": Audio.Timbangan,
	"Tinidor": Audio.Tinidor,
	"Tirador": Audio.Tirador,
	"Tolda": Audio.Tolda,
	"Tropeo": Audio.Tropeyo,
	"Troso": Audio.Troso,
	"Tsarira": Audio.Tsarira,
	"Tsinelas": Audio.Tsinelas,
	"Yawi": Audio.Yawi
}
func play_sfx(sfx: AudioStream) -> void:
	sfx_node.stop()
	sfx_node.set_stream(sfx)
	sfx_node.play()

func play_bgm(scene_bgm: AudioStream) -> void:
	bgm_node.stop()
	bgm_node.set_stream(scene_bgm)
	bgm_node.play()

#signal if not main menu or level select stop playing

func play_object(sfx: AudioStream) -> void:
	#print('sfx', sfx)
	object_sfx_node.stop()
	object_sfx_node.set_stream(sfx)
	object_sfx_node.set_volume_db(13)
	object_sfx_node.play()

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.




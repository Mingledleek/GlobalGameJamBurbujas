extends Control

@onready var menu: Control = $MenuPrincipal 
@onready var main_game := $MainGame 
@onready var instancia_nivel
@onready var seleccion_niveles := $SeleccionNiveles
@onready var menu_pausa := $MenuPausa
@onready var menu_perder := $MenuPerder

@export var oportunidades:int = 1
@export var jugador: Node #En inspector arrastrar la instancia del jugador

var jugando:bool

func _ready():# se llama al principio
	menu.show()
	menu_perder.hide()
	menu_pausa.hide()
	jugando = false
	seleccion_niveles.hide()
	if jugador != null:
		jugador.hide()

func unload_level():
	# Esta func se asegura que cuando se va a cargar un nivel, se elimine el actual
	if (is_instance_valid(instancia_nivel)):
		instancia_nivel.queue_free()
	instancia_nivel = null
	jugando = false
	if (jugador != null):
		jugador.hide()
	

func load_level(nombre_nivel : String):
	# Esta func recibe el nivel adecuado a cargar, elimina el anterior, y carga el nuevo
	# Los niveles se tienen que guardar en la carpeta niveles!!!
	seleccion_niveles.hide()
	if (jugador != null):
		jugador.show()
	unload_level()
	jugando = true
	var dir_nivel := "res://niveles/%s.tscn" %nombre_nivel 
	var nivel_actual = load(dir_nivel).instantiate()
	instancia_nivel = nivel_actual
	main_game.add_child(nivel_actual)

func _process(delta):
	if(jugando and Input.is_action_just_pressed("pausa")):
		menu_pausa.show()
		get_tree().paused 
	if(jugando and Input.is_action_just_pressed("debug_perder")):
		perder()
		
		
		

func win():
	# Logica para cuando el jugador llega al final del nivel
	
	pass


func perder():
	jugando = false
	menu_perder.show()
	pass

# FUNCIONES DEL MANEJO DE BOTONES EN MENUS
func _on_nivel_1_pressed():
	load_level("test_level_1")

func _on_nivel_2_pressed():
	load_level("test_level_2") 

func _on_nivel_3_pressed():
	load_level("test_level_3")

func _on_salir_pressed():
	get_tree().quit()

func _on_elegir_nivel_pressed():
	menu.hide()
	seleccion_niveles.show()


func _on_reanudar_pressed():
	menu_pausa.hide()
	


func _on_regresar_niveles_pressed():
	seleccion_niveles.show()
	menu_pausa.hide()
	unload_level()


func _on_reintentar_pressed():
	pass
	


func _on_seleccion_lvl_pressed():
	seleccion_niveles.show()
	menu_pausa.hide()
	menu_perder.hide()
	unload_level()

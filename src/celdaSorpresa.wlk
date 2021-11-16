import wollok.game.*
import consumibles.*
import elementos.*
import utilidades.*

class CeldaSorpresa{
	var property position = utilidades.posRand()
	var property image
	method puedePisarse() = true
	method puedeConsumirse() = false
	method puedeRecibirDanio() = false
	method afectar(player)
}
class CeldaResta inherits CeldaSorpresa {
	var property puntos
 	override method afectar(player) { 
 		player.energia(player.energia() - puntos)
 		game.removeVisual(self)	
 	}	
}
class CeldaSuma inherits CeldaSorpresa {
	var property puntos
 	override method afectar(player) { 
 		player.energia(player.energia() + puntos)
 		game.removeVisual(self)	
 	}
}
class CeldaTeleport inherits CeldaSorpresa{
	override method afectar(player){
		player.position(utilidades.posRand())
		game.removeVisual(self)
	}
}
class CeldaRandom inherits CeldaSorpresa {
 	override method afectar(player){
 		game.addVisual(new Salud(image='botiquin.png',aporta=30,position= utilidades.posRand()))
 		game.removeVisual(self)
 	} 	
}
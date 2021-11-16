import wollok.game.*
import direcciones.*
import fondo.*
import marcador.*
import nivel3.*
import personajes.*


object niveles3 {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image= "niveles3.png"))

		game.addVisualIn( player,game.at(13,7))
		
		// Marcadores
		const marcadores = [salud, saludNum, energia, energiaNum, dinero, dineroNum, municion, municionNum]
		marcadores.forEach{ elem => game.addVisual(elem) }
		
		// Movimientos
		keyboard.s().onPressDo({self.irAJuego() })	
	}
		
	method irAJuego() {		
		game.schedule(2000, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="instrucciones3.png"))
			// después de un ratito ...
			game.schedule(5000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				player.reset()
				nivelEnemigos.configurate()	
			})
		})
	}
		
}
import wollok.game.*
import direcciones.*
import nivel1.*

object player {
	var property position = game.center()
	var property image = "astrom.png"	
	var property energia = 30
	var property salud =  50
	var property dinero = 0
	var property municiones = 0
	var property direccion = izquierda
	var property disparosAcertados = 0
	var property paquetesMuniciones = 0
	
	method puedeRecibirDanio() = true
	method haceDanio() = false

	//COMER
	method comer(){
		const consumiblesArriba = self.objectoEnCeldaA(arriba).filter{ obj => obj.puedeConsumirse() and !obj.haceDanio()}
		const consumiblesAbajo = self.objectoEnCeldaA(abajo).filter{ obj => obj.puedeConsumirse() and !obj.haceDanio()}
		const consumiblesderecha = self.objectoEnCeldaA(derecha).filter{ obj => obj.puedeConsumirse() and !obj.haceDanio()}
		const consumiblesizquierda = self.objectoEnCeldaA(izquierda).filter{ obj => obj.puedeConsumirse() and !obj.haceDanio()}
		
		const todosLosConsumibles = [consumiblesArriba,consumiblesderecha,consumiblesAbajo,consumiblesizquierda].flatten()
		todosLosConsumibles.forEach{ consumible =>
			consumible.serConsumido(self)
			game.say(self, "+" + consumible.aporta() + "Up!")
		}
	}
	//RECOLECTAR DINERO
	method recolectar(elemento,nivel){
		if (elemento.puedeConsumirse() and elemento.haceDanio()){
			if (self.salud()<= 5){
				game.say(self, "Ouch!")
				elemento.serConsumido(self)
				self.morir(nivel) 
			}
			else {
				game.say(self, "Ouch!")
				elemento.serConsumido(self)
			}
		}
	}
	
	//EMPUJAR CAJAS
	method empujar(elemento){
		try{
			elemento.moverse(direccion)
		}catch e{
			self.retroceder()
			game.say(self,"Esta Atascada")
		}
	}
	method objectoEnCeldaA(dir){
		return game.getObjectsIn(dir.moverSiguiente(position,self))
	}
	method retroceder(){
		position = direccion.opuesto().moverSiguiente(position,self)
		energia += 1
	}
	method morir(nivel){
		image = "perdio.png"
		game.schedule(1500,{
			nivel.perder()
			}
		)
	}
	//MOVIMIENTOS
	method avanzar(nivel){
		if(energia > 0 and salud>0){
			position = direccion.moverSiguiente(position,self)
			energia-=1
		}else{
			self.morir(nivel)
		}		
	}
	//RESET
	method reset(){ //lo que sean los valores default
		image = "astrom.png"
		self.energia(30)
		self.salud(50)
		self.dinero(0)
		self.municiones(0)
		self.paquetesMuniciones(0)
		self.disparosAcertados(0)
	}
}


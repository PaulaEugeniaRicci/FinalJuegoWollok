import wollok.game.*
import direcciones.*

class Elementos{
	var property position
	const property image 
	method puedeRecibirDanio() = false
	method esPortal() = false
	method haceDanio() = false
	
	//Abstact
	method puedePisarse()
	method puedeConsumirse()
	method moverse(direccion)
}
class Cajas inherits Elementos {
	const property llegadas
	override method puedePisarse() = false
	override method puedeConsumirse() = false
	override method moverse(direccion){
		self.validarLugar(direccion)
		position = direccion.moverSiguiente(self.position(),self)
	}
	method validarLugar(direccion){
		const posAlLado = direccion.moverSiguiente(self.position(),self)
		const hayLugar = game.getObjectsIn(posAlLado).all{ obj => obj.puedePisarse()}
		
		if(!hayLugar){
			throw new Exception(message = "No puedo moverme!")
		}
	}
	method estaEnDeposito(){
		return llegadas.contains(self.position())
	}
}




import wollok.game.*

class Fondo {
	const property position = game.origin()
	var property image
	method puedePisarse() = true
	method puedeConsumirse() = false
	method puedeRecibirDanio() = false
	method haceDanio() = false
	method esPortal() = false
	method moverse(dir) {}
}

class Portal inherits Fondo {
	override method position() = game.center()
	override method esPortal() = true 
}






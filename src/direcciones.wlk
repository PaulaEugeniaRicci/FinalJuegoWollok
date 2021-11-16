import wollok.game.*

class Direcciones{
	method moverSiguiente(position,obj) 	
}

// DIRECCIONES CON EFECTO PAC-MAN
object izquierda inherits Direcciones{
	// retorna la siguiente posicion
	override method moverSiguiente(position,obj){
		if(obj.position().x()  == 0){
			return new Position(x=game.width()-1,y= position.y())
		}else{
			return position.left(1)
		}
	}
	method opuesto() = derecha
}
object derecha inherits Direcciones{
	method opuesto() = izquierda
	override method moverSiguiente(position,obj){
		if(obj.position().x()  == game.width()-1){
			return new Position(x=0,y= position.y())
		}else{
			return position.right(1)
		}
	}
}
object arriba inherits Direcciones{
	method opuesto() = abajo
	override method moverSiguiente(position,obj){
		if(obj.position().y() == game.height()-2){
			return new Position(x=position.x(),y= 0)
		}else{
			return position.up(1)
		}
	}
}
object abajo inherits Direcciones{
	method opuesto() = arriba
	override method moverSiguiente(position,obj){
		if(obj.position().y()  == 0){
			return new Position(x=position.x(),y= game.height()-2)
		}else{
			return position.down(1)
		}
	}
}

import wollok.game.*
import direcciones.*

object utilidades {
	method posRand() {
		return game.at(
			0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()-1).truncate(0)
		)
	}
	method randNumX() {
		return 1.randomUpTo(game.width()-1).truncate(0)
	}
	method randNumY() {
		return 2.randomUpTo(game.height()-1).truncate(0)
	}	
	
	method dirRand(){
		return [izquierda,derecha,arriba,abajo].anyOne()
	}
	
	method posRandVacia(pos){
		if (game.getObjectsIn(pos).size() == 0){
			return pos
		}else{
			return self.posRandVacia(self.posRand())
		}
	}
}



import wollok.game.*
import personajes.*

object energia{
	var property position = game.at(1,game.height()-1)
	method image(){
		var img
		if(player.energia()>=21){
			img= "bateriaCompleta.png"
		}if(player.energia().between(11,20)){
			img= "bateriaMitad.png"
		}if(player.energia().between(0,10)){
			img= "bateriaBaja.png"
		}
	return img}
}
object energiaNum{
	var property position = game.at(2,game.height()-1)
	method text()="  " +  player.energia()
}
object salud{
	var property position = game.at(4,game.height()-1)
	method image()= "salud.png "
}
object saludNum{
	var property position = game.at(5,game.height()-1)
	method text() = " " + player.salud()
}
object dinero{
	var property position = game.at(7,game.height()-1)
	method image()= "dinero.png "
}
object dineroNum{
	var property position = game.at(8,game.height()-1)
	method text() = "  " + player.dinero()
}
object municion{
	var property position = game.at(11,game.height()-1)
	method image()= "granada.png "
}
object municionNum{
	var property position = game.at(12,game.height()-1)
	method text() = " " + player.municiones()
}
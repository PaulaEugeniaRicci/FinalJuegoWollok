import wollok.game.*
import consumibles.*
import deposito.*
import direcciones.*
import elementos.*
import enemigos.*
import fondo.*
import inicio.*
import inicio3.*
import marcador.*
import nivel2.*
import personajes.*
import utilidades.*


object nivelEnemigos {
	method configurate() {
		// FONDO - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image="fondo.png"))
		
		//MARCADORES
		const marcadores = [salud, saludNum, energia, energiaNum, dinero, dineroNum, municion, municionNum]
		marcadores.forEach{ elem => game.addVisual(elem)}
		
		// CONSUMIBLES - NIVEL 3
			
		// 2. SALUD
		const salud1 = []
		5.times({ i=> salud1.add(new Salud(position= utilidades.posRandVacia(utilidades.posRand()), aporta = 15, image = "botiquin.png")) })
		salud1.forEach({ c => game.addVisual(c)})
	
		// 3. ENERGIA
		const energia1 = []
		5.times({ i=> energia1.add(new Energia(position= utilidades.posRandVacia(utilidades.posRand()), aporta = utilidades.randNumX(), image = "hamburger.png")) })
		energia1.forEach({ c => game.addVisual(c)})
		
		// 3.ENEMIGOS 
		const enemigosNormalYAcecho = []
		const enemigoRand= []
		
		2.times({ i=> enemigosNormalYAcecho.add(new EnemigoNormal(position = utilidades.posRand(), image="alien.png", nivelDanio = 3, direccion = izquierda))})
		2.times({ i=> enemigoRand.add(new EnemigoRandom(position = utilidades.posRand(), image="meteorito.png", nivelDanio = 10, direccion = izquierda))})
		1.times({ i=> enemigosNormalYAcecho.add(new EnemigoAlAcecho(position = utilidades.posRand(), image="meteorito2.png",nivelDanio = 15, direccion = izquierda))})
		
		enemigosNormalYAcecho.forEach{ e => game.addVisual(e)}
		enemigoRand.forEach{ e => game.addVisual(e)}
		
		const objetivoEnemigos = enemigosNormalYAcecho.size() + enemigoRand.size()
		const enemigos= enemigoRand + enemigosNormalYAcecho
		
		// 4.MUNICIONES
		const municiones = []
		5.times({ i=> municiones.add(new Municion (aporta = 4, position =  utilidades.posRandVacia(utilidades.posRand()), image = 'granada.png'))})
		municiones.forEach{ m => game.addVisual(m)}
		
		// PJ, es importante que sea el último visual que se agregue
		game.addVisual(player)
				 
				 
		// TECLADO-MOVIMIENTOS
		keyboard.up().onPressDo({ player.direccion(arriba) player.avanzar(self) })
		keyboard.down().onPressDo({ player.direccion(abajo) player.avanzar(self) })
		keyboard.left().onPressDo({ player.direccion(izquierda) player.avanzar(self) })
		keyboard.right().onPressDo({ player.direccion(derecha) player.avanzar(self) })
		keyboard.space().onPressDo({ player.comer()})			
		keyboard.s().onPressDo({ self.disparar(objetivoEnemigos) })
		keyboard.any().onPressDo({self.morirSinMuniciones(objetivoEnemigos)})
		
		// FINALES DEL NIVEL
		keyboard.q().onPressDo({ self.perder() })
		keyboard.r().onPressDo({ self.restart() })
		
		// COLISIONES
		enemigos.forEach{ e => 
			game.whenCollideDo(e, {jugador => 
				if(jugador.puedeRecibirDanio() and !jugador.haceDanio()){
					e.hacerDanio(jugador)
					if (jugador.salud()<=0) { self.perder() }
				}
			})
		}
		
		municiones.forEach{ m =>
			game.whenCollideDo(m, {elemento =>
				// si es player ==> consume
 				if (elemento.puedeRecibirDanio() and !elemento.haceDanio()) { m.serConsumido(player) player.paquetesMuniciones(player.paquetesMuniciones()+1) }
			})
		}

		
		// MOVIMIENTOS				
		enemigosNormalYAcecho.forEach{ e => 
			game.onTick(1000,"movimientoEnemigo",{
			if (e.seDesplazaNormal()){ e.desplazarse() }
			else{ e.desplazarseHacia(player) }
			})
		}
		
		enemigoRand.forEach{ e => 
			game.onTick(2500,"movimientoEnemigo",{
			if (e.seDesplazaNormal()){ e.desplazarse() }
			else{ e.desplazarseHacia(player) }
			})
		}
	}
	
	// METODOS
	method disparar(objetivoEnemigos){ //Este metodo hace basicamente todo lo del nivel 3
		if (player.municiones()>0){
			const direccion = player.direccion()
			const posicion = direccion.moverSiguiente(player.position(), player)
			const bala = new Municion(aporta = 4, position = posicion, image = "bang.png")
			game.addVisual(bala)
			player.municiones(player.municiones() - 1)
			game.whenCollideDo(bala, {elemento =>
 				if (elemento.puedeRecibirDanio() and elemento.haceDanio()) { 
 					game.removeVisual(elemento) game.removeVisual(bala) player.disparosAcertados(player.disparosAcertados()+1 )
 						self.pasarNivel(objetivoEnemigos)
 				}
			})
			game.schedule(1000, { => bala.avanzar(direccion) })
			game.schedule(2000, { => bala.avanzar(direccion) })
			game.schedule(3000, { => bala.avanzar(direccion) })
			game.schedule(4000, { => if(game.hasVisual(bala)) game.removeVisual(bala) })
		}
		else { game.say(player, "No tengo municiones!") }
	}
	method morirSinMuniciones(cantidadEnemigosEnTablero){
		if(player.paquetesMuniciones() == 5 and player.municiones() <= 0 and cantidadEnemigosEnTablero > player.disparosAcertados()){
			game.say(player,"Me quede sin municiones, perdimos")
			game.schedule(2000,{
				self.perder()
			})
			
		}
	}
	method restart() {
		player.reset()
		game.clear()
		self.configurate()
	}
	method pasarNivel(objetivo){
		if (objetivo == player.disparosAcertados()){ 
			self.ganar()
		}
	}
	method ganar(){ 
		self.terminar()
	}
	method perder(){
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(position = game.at(0,0),image="gameover.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="nivel3.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				player.reset()
				game.clear()
				niveles3.configurate()
			})
		})
	}
	method terminar() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.schedule(1500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="ganador.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				player.reset()
				// y arranco el siguiente nivel
				niveles.configurate()
			})
		})
	}	
}

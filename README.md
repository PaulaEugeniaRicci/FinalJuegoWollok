
# Juego de aventura

Se debe desarrollar un juego con al menos dos niveles diferenciados. 


## Estructura inicial
El código que acompaña a este enunciado tiene una estructura básica del juego, incluyendo los dos niveles, y cómo hacer la transición entre niveles. Están resueltas: la transición del nivel 1 al 2, y el fin de juego en caso de ganar. Falta manejar el caso de perder.

Se agregan algunos visuals de ejemplos en cada nivel, una tecla en el nivel 1 **(tecla t)** para simular que se terminó el nivel y así pasar al siguiente, y una tecla en el nivel 2 **(tecla g)** para simular que se ganó. Estas funcionalidades son para probar: los visuals deben reemplazarse por los que implementen ustedes; con las teclas como prefieran, déjenlas como están, cambien de tecla, o bórrenlas.


## Algunas cosas que obligatoriamente deben implementar
- El juego debe tener un personaje principal que pueda moverse en ambos niveles y tener al menos energía y salud. Las teclas del movimiento deberán ser las teclas  (↓) (↑) (→) (←)
- En el juevo siempre deberán estar visibles los indicadores de energía y salud del personaje principal. Puede tener otros indicadores como por ejemplo: cantidad de granadas 
- Efecto tipo pac-man, esto quiere decir que si por ejemplo, el personaje principal esta posicionado sobre cualquier columna en la fila superior del tablero  y  se presiona la flecha arriba (↑), entonces el personaje deberá aparecer en la parte inferior del tablero. Esta funcionalidad debe ser independiente del tamaño del tablero (no vale hardcodear los valores de alto y ancho)
- El personaje principal deberá poder mover objetos, para ello debe posicionarse detrás del objeto. P.ej. si el personaje está a la izquierda de una caja y se mueve hacia la derecha, entonces la caja se mueven en forma conjunta.
- Se deben agregar varios tipos de objetos como por ejemplo, hamburgueas y gaseosas que dan energía, otros que dan salud (ponele, un botiquín), otros que deben ser acumulables (tipo cajas,llaves, etc) y otros que otorgan dinero (ligontes de oro, monedas, etc)
- También debe tener bichos con movimientos aleatorios, pero también que se muevan hacia el personaje y si lo chochan el personaje pierde salud.

## Celdas sorpresa
Agregar al tablero elementos con efectos variados, p.ej.
- uno quita 15 puntos de energía.
- otro agrega 30 puntos de energía.
- otro hace aparecer un objecto en un posicion aleatorea.
- otro "teletransporta" a otra posición.


## Objetivo Nivel 1 - Agrupar objetos cuidando la energía

El objetivo del nivel 1 debe ser agrupar varios objetos acumulables en una zona determinada del tablero, por ejemplo, tener 3 cajas y 3 llaves en una zona que se llame deposito del tablero. La zona del deposito se deberá generar en forma aleatoria cuando inicia el nivel. Cuando todos los objetos acumulables están en la zona del deposito automáticamente se pasa al nivel 2.

Si el personaje se queda sin energía, entonces pierde. A cada paso que da el personaje, gasta una unidad de energía. El personaje arranca el nivel con 30 unidades de energía.  

Para recuperar energía, el personaje tiene que **agarrar** objetos que le otorguen energía. Para ello debe estar en una posición pegada al objeto y mediante una tecla agarrarlo. Cada objeto que suministra energía tiene una cantidad de unidades de energía que se establece en forma particular para cada uno, p.ej. podríamos tener una hamburguesa que dé 10 unidades de energía y otra que dé 5.

## Objetivo Nivel 2 - Ganar Dinero con salud

En el nivel 2 el objetivo del personaje es ganar dinero. El personaje gana dinero cuando **colisiona** con los objeto que otorgan dinero. Al colisionar con un objeto que otorga dinero el personaje acumula el dinero que le otorga, el objeto desaparece del tablero y el personaje pierde salud. 

Un detalle **muy importante**: debe aparecer una puerta de salida para finalizar el nivel 2 _recién_ cuando el personaje colisono con todos los objetos que otorgan dinero y aún conserva energía 

 
Si el personaje se queda sin salud , entonces pierde. Si pasa por la puerta de salida, entonces gana. En cualquiera de los dos casos, debe aparecer un cartel que indique el resultado.



## Mega bonus
Agregar un nivel 3, en el que hay bichos que se mueven automáticamente. El objetivo es matar todos los bichos, lanzándoles granadas. La granada recorre hasta 3 celdas en la dirección del último movimiento del personaje. Si un bicho se choca con el personaje, entonces le resta 20 unidades de salud, y vuelve a su posición anterior.  
Atenti: el personaje nace sin granadas, tiene que recogerlas del tablero. 

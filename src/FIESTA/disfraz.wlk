import fiesta.*

class Disfraz {
	var property nombre = ""
	var property fechaConfeccion = new Date()
	const listaCaracteristicas = []
	var property nivelDeGracia = 10
	//var property propietario
	
	
	method agregarCaracteristica(caracteristica) {listaCaracteristicas.add(caracteristica)}
	
	method VerificarFecha(fiesta, dias) = fechaConfeccion < fiesta.fecha().minusDays(dias)
	
	method puntaje(persona, fiesta) = listaCaracteristicas.sum({caracteristica => caracteristica.puntaje(persona, self, fiesta)})
	
	method nombrePar() = nombre.length().even()
}


object gracioso {
	method puntaje(persona, disfraz, fiesta) = disfraz.nivelDeGracia() * (if (persona.edadMayorA50()) 3 else 1)
}


object tobaras{
	method puntaje(persona, disfraz, fiesta) {
		if (disfraz.VerificarFecha(fiesta, 2))
			return 5
		else
			return 3		
	}
}

object caretas {
	var property personajeSimulado = mickeyMouse
	
	method puntaje(persona, disfraz, fiesta) = personajeSimulado.valor()
}

class Personaje {
	var property valor 
}

const mickeyMouse = new Personaje(valor = 8)
const osoCarolina = new Personaje (valor = 6)


object sexies {
	method puntaje(persona, disfraz, fiesta) {
		if(persona.esSexy())
			return 15
		else
			return 2
	}
}



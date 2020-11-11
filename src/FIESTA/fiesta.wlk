import disfraz.*

class Fiesta {
	var property lugar
	var property fecha
	var property invitados = []
	
	method agregarInvitado(invitado) { invitados.add(invitado)}
	
	method EsBodrio() = invitados.all({invitado => !invitado.satisfecho(self)})
	
	method mejorDisfraz() = invitados.max({invitado => invitado.puntajeDisfraz(self)}).disfraz()
	
	method puedenIntercambiarTrajes(persona1, persona2) = self.verificarAsistencia(persona1, persona2) and 
														self.disconformeTraje(persona1, persona2) and 
														self.satisfechoPorCambioTraje(persona1, persona2)
	
	method verificarAsistencia(persona1, persona2) = invitados.contains(persona1) and invitados.contains(persona2)
	
	method disconformeTraje(persona1, persona2) = !persona1.satisfecho(self) or !persona2.satisfecho(self)
	
	method satisfechoPorCambioTraje(persona1, persona2) = 	persona1.satisfechoPorCambioDisfraz(persona2.disfraz(), self) and 
															persona2.satisfechoPorCambioDisfraz(persona1.disfraz(), self)
	method agregarAsistente(asistente){
		if(!(asistente.disfraz() == null) and !self.asistentePresente(self))
			self.agregarInvitado(asistente)
		else
			self.error("asistente presente o sin traje")
	}

	method asistentePresente(asistente) = invitados.contains(asistente)
	
}

class FiestaInolvidable inherits Fiesta {
	method esUnica() = invitados.all({invitado => invitado.esSexy() and invitado.Satisfecho()})
}

class Invitado {
	var property disfraz = null
	var property edad
	var property personalidad
	
	method edadMayorA50() = edad > 50
	
	method esSexy() = personalidad.esSexy(self)
	
	method satisfecho(fiesta) = disfraz.puntaje(self, fiesta) > 10
	
	method puntajeDisfraz(fiesta) = disfraz.puntaje(self, fiesta)
	
	method satisfechoPorCambioDisfraz(elDisfraz, fiesta) {
		disfraz = elDisfraz
		return self.satisfecho(fiesta)
	}
	
	//method criterioDeAsistencia(fiesta) = !(self.disfraz() == null) and !fiesta.asistentePresente(self)
	
}

object alegre {
	method esSexy(persona) = false
}

object taciturna{
	method esSexy(persona) = persona.edad() < 30
}

class Cambiante{
    var property personalidad

    method cambiarPersonalidad(nueva) = self.personalidad(nueva)

    method esSexy(persona) = personalidad.esSexy(persona)
}


class Caprichoso inherits Invitado {
	override method satisfecho(fiesta) = super(fiesta) and disfraz.nombrePar()
}

class Pretencioso inherits Invitado {
	override method satisfecho(fiesta) = super (fiesta) and disfraz.VerificarFecha(fiesta, 30)
}

class Numerologo inherits Invitado {
	var property puntajeParaElDifraz
	
	override method satisfecho(fiesta) = super (fiesta) and disfraz.puntaje(self, fiesta) == puntajeParaElDifraz
}

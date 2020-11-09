import agente.*
import inmueble.*

object inmobiliaria {
	const agentes = []
	//const operaciones = []
	var property mejorEmpleado
	
	method reservar(inmueble, cliente, agente){
		inmueble.reservar(cliente)
		agente.agregarReserva(inmueble)
	}
	
	method concretarOperacion(inmueble, cliente, agente){
		inmueble.concretar(cliente, agente)
		agente.agregarOperacionConcretada(inmueble)
	}
	
	method contratar(agente){
		agentes.add(agente)
	}
	
	method buscarMejorEmpleado(criterio) {
		const lista = criterio.filtro(agentes)
		
		if(lista.size() > 1)
			self.error("hay empate")
		else
			mejorEmpleado = criterio.ranking(agentes)
	}	
	
}





//ZONAS
object palermo {
	var property plus = 1000
}


// CRITERIOS
object totalComisiones{
	method ranking(agentes) = agentes.max({agente => agente.maximaComisionRecibida()})
	method filtro(agentes) {
		const aux = self.ranking(agentes)
		return agentes.filter({agente => agente.maximaComisionRecibida() == aux.maximaComisionRecibida()})
	}
	
}

object cantOperacionesCerradas{
	method ranking(agentes) = agentes.max({agente => agente.cantComisiones()})
	method filtro(agentes) {
		const aux = self.ranking(agentes)
		return agentes.filter({agente => agente.cantComisiones() == aux.cantComisiones()})
	} 
}

object cantReservas{
	method ranking(agentes) = agentes.max({agente => agente.cantReservas()})
	method filtro(agentes) {
		const aux = self.ranking(agentes)
		return agentes.filter({agente => agente.cantReservas() == aux.cantReservas()})
	} 
}


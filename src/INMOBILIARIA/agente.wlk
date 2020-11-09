import inmobiliaria.*

class Agente {
	const operacionesConcretadas = []
	const reservas = []
	
		
	method get_reservas() = reservas 
	
	method get_operacionesConcretadas() = operacionesConcretadas
	
	method agregarOperacionConcretada(inmueble) { operacionesConcretadas.add(inmueble)}
	
	method operacionesConcretadas() = operacionesConcretadas.sum({inmueble => inmueble.valorComision()})
	
	method cantComisiones() = operacionesConcretadas.size()
	
	method cantReservas() = reservas.size()
		
	method agregarReserva(inmueble){ reservas.add(inmueble) }
	
	method problemaPotencialCon(agente, zona) = self.criterioOperacionCerrada(agente, zona) and self.criterioOperacionRobada(agente, zona)
		
	method operacionesCerradasEn(zona) = operacionesConcretadas.any({inmueble => inmueble.zona() == zona})
	
	method roboOperacion(agente, zona) {
		const aux = operacionesConcretadas.filter({inmueble => inmueble.zona() == zona})
		const aux2 = agente.get_reservas()
		if (aux2.size() == 0)
			return false
		else{
			const aux3 = aux2.filter({inmueble => inmueble.zona() == zona})
			return aux3.any({inmueble => aux.contains(inmueble)})
		}		
	}
	
	method maximaComisionRecibida() = operacionesConcretadas.max({inmueble => inmueble.valorComision()}).valorComision()
	
	method criterioOperacionCerrada(agente, zona) = self.operacionesCerradasEn(zona) and agente.operacionesCerradasEn(zona)
	
	method criterioOperacionRobada(agente, zona) = self.roboOperacion(agente,zona) or agente.roboOperacion(self, zona)

}
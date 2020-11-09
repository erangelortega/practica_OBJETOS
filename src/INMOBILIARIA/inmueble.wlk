// INMUEBLES ----------------------------------
class Inmueble {
	var property tamanio
	var property ambientes
	var property operacion
	var property tipoInmueble
	var property zona
	var property reservar = false
	var property cliente = ""
	
	method valorComision() = operacion.calcularComision(self)
	
	method valorInmueble() = tipoInmueble.valor(self) + zona.plus()
	
	method reservar(nuevoCliente, agente){
		if (!reservar){
			reservar = true
			cliente = nuevoCliente
			agente.agregarReserva(self)
		}
		else
			self.error("inmueble reservado por otro cliente")
	}
	
	method concretar(elCliente, agente){
		if((reservar and cliente == elCliente) or !reservar)
			agente.agregarOperacionConcretada(self)
		else 
			self.error("inmueble reservado por otro cliente")	
	}
	
	method tipoOperacion(laOperacion){
		if(self.operacionProhibida(laOperacion))
			self.error("Operacion restringida para este inmueble")
		else
			operacion = laOperacion
	}
	
	method operacionProhibida(laOperacion) = laOperacion == venta and (tipoInmueble == galpon or tipoInmueble == localALaCalle)
}



//OPERACION
object alquiler {
	var property meses = 12

	method calcularComision(inmueble) = meses * inmueble.valorInmueble() / 50000
}

object venta {
	var property porcentaje = 1.5
	
	method calcularComision(inmueble) = porcentaje * inmueble.valorInmueble() / 100
}




// TIPO INMUEBLE
class Casa{
	var property valorInmueble = 0
	
	method valor(inmueble) = valorInmueble
}

object casa inherits Casa{ }

object ph {
	method valor(inmueble) = (14000 * inmueble.tamanio()).max(500000)
}

object departamento {
	method valor(inmueble) = 350000 * inmueble.ambientes()
}

object galpon inherits Casa{
	override method valor(inmueble) = valorInmueble / 2
}

object localALaCalle inherits Casa{
	var property montoFijo
	override method valor(inmueble) = montoFijo
}
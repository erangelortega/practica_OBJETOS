import consumos.*
import packs.*

class Linea {
	var property numeroTelefono
	const packs = new List()
	const consumos = new List()
	const hoy = new Date()
	var property tipoLinea
	var property deuda = []
	
	method consumos() = consumos	
		
	method agregarConsumo(consumo) { consumos.add(consumo)}
	
	method promedioConsumo(fechaInicial, fechaFinal){
		const aux = self.filtrarConsumoPorFechas(fechaInicial, fechaFinal)
		return aux.sum({consumo => consumo.costo()})	/ aux.size()
	}
	
	method filtrarConsumoPorFechas(fechaInicial, fechaFinal) = consumos.filter({consumo => consumo.fecha().between(fechaInicial, fechaFinal)})
	
	method consumoUltimos30Dias(){
		const aux = self.filtrarConsumoPorFechas(hoy.minusDays(30), hoy)
		return aux.sum({consumo => consumo.costo()})
	}
	
	method agregarPack(pack) { packs.add(pack) }
	
	method puedeHacer(consumo) = tipoLinea.puedeHacer(consumo, self)
	
	method puedeSatisfacer(consumo) = packs.any({pack => pack.aptoParaConsumo(consumo)})
	
	method consumir(consumo){
		if(self.puedeHacer(consumo)){
			
			tipoLinea.realizarConsumo(consumo, self)
		}
		else
			self.error("no se puede hacer el consumo")
	}
	
	method cleanPacks() {
		const aux = packs.filter({pack => pack.aptoParaLimpieza()})
		aux.forEach({pack => packs.remove(pack)})
	}
	
	method agregarDeuda(consumo) {deuda.add(consumo) self.agregarConsumo(consumo)}
	
	method efectuarConsumo(consumo){
		const aux = packs.filter({pack => pack.aptoParaConsumo(consumo)}).last()
		packs.remove(aux)
		aux.gastar(consumo)
		packs.add(aux)
		self.agregarConsumo(consumo)	
	}

	//getters
	method getPacks() = packs
	method getConsumos() = consumos
}



// TIPOS DE LINEAS----------------------------------------------------

object comun{
	method puedeHacer(consumo, linea) = linea.puedeSatisfacer(consumo)
	
	method realizarConsumo(consumo, linea){
		linea.efectuarConsumo(consumo)
	}
}

object black {
	method puedeHacer(consumo, linea) = true
	
	method realizarConsumo(consumo, linea){
		const aux = linea.getPacks().filter({pack => pack.aptoParaConsumo(consumo)})
		
		if(aux.size() == 0)
			linea.agregarDeuda(consumo)
		else
			linea.efectuarConsumo(consumo)
	}
}

object platinum {
	method puedeHacer(consumo, linea) = true
	method realizarConsumo(consumo, linea){
		const aux = linea.getPacks().filter({pack => pack.aptoParaConsumo(consumo)})
		if(aux.size() == 0)
			linea.agregarConsumo(consumo)
		else
			linea.efectuarConsumo(consumo)
	}
}




class Vikingo {
	var property casta
	var monedas = 0
	var vidasCobradas = 0

	method esProductivo() = true
	
	method ascender() = casta.ascender(self)
	
	method monedas(masMoney) { monedas += masMoney}
	
	method actualizarVidasCobradas() { vidasCobradas += 1}
	
}


// TIPO VIKINGO -------------------
class Soldado inherits Vikingo {

	var property armas
	
	override method esProductivo() {
		return vidasCobradas > 20 and casta.controlDeArmas(armas)
	} 
		
	method obtenerBonificacion(){
		armas += 10
	}
	
}

class Granjero inherits Vikingo {
	var property cantHijos
	var property cantHectareas
	
	override method esProductivo() = cantHectareas.div(cantHijos) >= 2
	
	method obtenerBonificacion(){
		cantHijos += 2
		cantHectareas += 2
	}
	
}



//CASTAS -------------------------
class Casta {
	method controlDeArmas(armas) = armas > 0
	method ascender(vikingo){}
}

object jarl inherits Casta {
	override method controlDeArmas(armas) = !super(armas)
	
	override method ascender(vikingo){
		vikingo.casta(karl)
		vikingo.obtenerBonificacion()
	}
}

object karl inherits Casta {
	override method ascender(vikingo){
		vikingo.casta(thrall)
		vikingo.obtenerBonificacion()
	}
}

object thrall inherits Casta {}



//EXPEDICION ----------------------
class Expedicion {
	const property vikingos = []
	const lugaresObjetivos = []
	var botin = 0
	
	method agregarObjetivo(lugar){
		lugaresObjetivos.add(lugar)
	}
	
	method subir(vikingo){
		if(vikingo.esProductivo())
			vikingos.add(vikingo)
		else
			throw new Exception(message = "no se puede agregar vikingo a la expedicion")
	} 
	
	method valeLaPena(){
		return lugaresObjetivos.all({ lugar => lugar.valeLaPena(self.cantVikingos())})
	}
	
	method cantVikingos() = vikingos.size()
	
	method realizar(){
		lugaresObjetivos.forEach({lugar => lugar.invadir(self)})
		vikingos.forEach({vikingo => vikingo.monedas(self.repartirBotin())})
	}
	
	method botin(masMoney) {botin += masMoney}
	method repartirBotin() = botin / self.cantVikingos()
}



// OBJETIVO DE INVASION ------------------------
class Objetivo {
	method valeLaPena(vikingos) 
	method botin(vikingos)
	method invadir(expedicion){
		expedicion.botin(self.botin(expedicion.cantVikingos()))
		self.destruir(expedicion.cantVikingos())
	}
	method destruir(vikingos)
}

class Capital inherits Objetivo{
	var property factorDeRiqueza
	var property defensores
	
	override method valeLaPena(vikingos) = self.botin(vikingos).div(vikingos) >= 3
	
	override method botin(vikingos) = self.defensoresDerrotados(vikingos) * factorDeRiqueza  
	
	method defensoresDerrotados(vikingos) = defensores.min(vikingos)
	
	override method destruir(vikingos) {
		defensores = (vikingos - defensores).max(0)
		vikingos.take(self.defensoresDerrotados(vikingos)).forEach({vikingo => vikingo.actualizarVidasCobradas()})
	}
}



class Aldea inherits Objetivo{
	var property cantCrucifijos
	
	override method valeLaPena(vikingos) = self.botin(vikingos) >= 15
	
	override method botin(vikingos) = cantCrucifijos
	
	override method destruir(vikingos) {
		cantCrucifijos = 0
	}
}

class AldeaAmurallada inherits Aldea{
	var property cantMinVikingos
	
	override method valeLaPena(vikingos) = cantMinVikingos <= vikingos and super(vikingos)

}
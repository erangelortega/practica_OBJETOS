import packs.*
import example.*

class Pack {
	var property fechaVencimiento
	
	method puedeSatisfacer(consumo) 
	
	method aptoParaConsumo(consumo) = self.puedeSatisfacer(consumo) and fechaVencimiento > consumo.fecha()
	
	method gastar(consumo) {}
	
	method aptoParaLimpieza() = fechaVencimiento < new Date()
	
}

class Credito inherits Pack {
	var property cantidad
	
	override method puedeSatisfacer(consumo) = cantidad >= consumo.costo()
	
	override method gastar(consumo) {cantidad -= consumo.costo()}
	
	override method aptoParaLimpieza() = super() or cantidad == 0
	
}

class InternetLibre inherits Pack {
	var property cantidad
	
	override method puedeSatisfacer(consumo) = consumo.unidad() == "MB" and cantidad >= consumo.cantidad()
	
	override method gastar(consumo) {cantidad -= consumo.cantidad()}
	
	override method aptoParaLimpieza() = super() or cantidad == 0
}

class LlamadasGratis inherits Pack {
	override method puedeSatisfacer(consumo) = consumo.unidad() == "SG"
}

class IntenetIlimitadoWeekend inherits Pack {
	override method puedeSatisfacer(consumo) = consumo.unidad() == "MB" and consumo.esWeekend()
}

class MBlibresPlus inherits InternetLibre {
	override method puedeSatisfacer(consumo) = super(consumo) or (consumo.unidad() == "MB" and consumo.cantidad() <= 0.1 and cantidad == 0)
	
	override method gastar(consumo) {
		if(cantidad > 0)
			super(consumo)			
	}
}
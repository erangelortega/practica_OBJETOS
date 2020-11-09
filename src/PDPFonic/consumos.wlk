class Consumo {
	var property fecha
	var property cantidad
	
	method costo()
	method esWeekend() = true
}

class ConsumoInternet inherits Consumo{
	const unidad = "MB"
	var property precio = 0.1
	
	override method costo() = cantidad * precio
	
	method unidad() = unidad
	
	override method esWeekend() = fecha.dayOfWeek() == sunday or fecha.dayOfWeek() == saturday
}

class ConsumoLlamada inherits Consumo {
	const unidad = "SG"
	var property precioFijoLlamada = 1
	var property precio = 0.05
	
	override method costo() = precioFijoLlamada + ((cantidad - 30) * precio)
	method unidad() = unidad
}
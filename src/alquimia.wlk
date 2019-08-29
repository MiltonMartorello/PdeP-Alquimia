/*  1 Saber si los alquimista tienen criterio. Esto se cumple si al menos la mitad de sus items de combate son efectivos 
 *  2 Saber si son buenos exploradores, esto se cumple si poseen al menos tres tipos diferentes de items de recolección
*/

object alquimista {
	var itemsDeCombate = []
	
	method tieneCriterio(){
		return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadItemsDeCombate() / 2	
	}
	
	method cantidadItemsDeCombate(){
		return itemsDeCombate.size()
	}
	
	method cantidadDeItemsDeCombateEfectivos(){
		return itemsDeCombate.count({itemDeCombate => itemDeCombate.esEfectivo()})
	}
	
}

object bomba {
	var danio = 15
	
	method esEfectivo(){
		return danio > 100
	}
}


object pocion {
	var poderCurativo = 20
	
	method esEfectivo (){
		return poderCurativo > 50 && self.creadaConMaterialMistico()
	}
	
	method creadaConMaterialMistico(){
		return true
	}
}

object debilitador {
	var debilitamientos = []
	
	method esEfectivo(){
		return (self.infringeAlgunDecrecimiento() and self.creadaConMaterialMistico().negate())
	}
	
	method creadaConMaterialMistico(){
		return true
	}
	
	method infringeAlgunDecrecimiento(){
		return debilitamientos.isEmpty()
	}
}

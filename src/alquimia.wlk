/*  1 Saber si los alquimista tienen criterio. Esto se cumple si al menos la mitad de sus items de combate son efectivos 
 *  2 Saber si son buenos exploradores, esto se cumple si poseen al menos tres tipos diferentes de items de recolección
 *  3 Saber su capacidad ofensiva, que es la suma de la capacidad de cada item de combate.
 *  La capacidad se calcula como:
 * bomba: la mitad del daño
 * pocion: su poder curativo mas 10 puntos extras por cada material mistico que contiene
 * debilitador: un valor por defecto de 5 salvo que contenga algun material mistico en cuyo caso el valor pasa a ser 12 por cada material
 *  4 Saber si es profesional, esto se cumple si la calidad promedio de todos sus items es mayor a 50, todos sus items de combate sos 
 * efectivos y es buen explorador.
*/

object alquimista {
	var itemsDeCombate = []
	var itemsDeRecoleccion = []
	
	method tieneCriterio(){
		return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadItemsDeCombate() / 2	
	}
	
	method cantidadItemsDeCombate(){
		return itemsDeCombate.size()
	}
	
	method cantidadDeItemsDeCombateEfectivos(){
		return itemsDeCombate.count({itemDeCombate => itemDeCombate.esEfectivo()})
	}
	
	method esBuenExplorador(){
		return itemsDeRecoleccion.size() >= 3
	}
	
	method capacidadOfensiva(){
		return self.capacidadOfensivaDeItemsDeCombate().sum()
	}
	
	method capacidadOfensivaDeItemsDeCombate(){
		return itemsDeCombate.map(){item => item.capacidadOfensiva()}
	}
	
	method esProfesional(){
		
	}
}

object bomba {
	var danio = 15
	var materiales = []
	
	method esEfectivo(){
		return danio > 100
	}
	
	method capacidadOfensiva(){
		return danio / 2
	}
	
	method calidad(){
	return materiales.min{material => material.calidad()}
	}
}


object pocion {
	var poderCurativo = 20
	var materiales = []
	
	method esEfectivo (){
		return poderCurativo > 50 && self.creadaConMaterialMistico()
	}
	
	method creadaConMaterialMistico(){ // true hasta que la justicia demuestre lo contrario
		return true
	}
	
	method capacidadOfensiva(){
		return poderCurativo + 10 * cadaMaterialMistico()
	}	
	
	method cadaMaterialMistico(){ // incompleto por ahora devuelve 2
		return 2
	}
	
	method calidad(){
		return materiales.findOrElse({material => material.esMistico()},{material => material.head()}).calidad()
	}
}

object debilitador {
	var debilitamientos = []
	var materiales = []
	
	method esEfectivo(){
		return (self.infringeAlgunDecrecimiento() and self.creadaConMaterialMistico().negate())
	}
	
	method creadaConMaterialMistico(){ // true hasta que la justicia demuestre lo contrario
		return true
	}
	
	method infringeAlgunDecrecimiento(){
		return debilitamientos.isEmpty()
	}
	
	method capacidadOfensiva(){
		if self.creadaConMaterialMistico(){
			return 12 * cadaMaterialMistico()
		}
		return 5
	}
		
	method cadaMaterialMistico(){ // incompleto por ahora devuelve 2
		return 2
	}
	
	method calidad(){
		return materiales.sortedBy{materiales.min()}.take(2)
	}
}


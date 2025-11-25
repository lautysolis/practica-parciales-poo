class Plato{

var caloriasBase = 100
const cocinero

method cantidadDeAzucar() 

method cocinero() = cocinero 

method calorias() = 3 * self.cantidadDeAzucar() + caloriasBase

}


class Entrada inherits Plato{

override method cantidadDeAzucar() = 0 

 method esBonito() = true 

}

class Principal inherits Plato{

const esBonito 
const cantidadDeAzucar

override method cantidadDeAzucar() = cantidadDeAzucar

method esBonito() = esBonito

}

class Postre inherits Plato{

const cantidadColores

override method cantidadDeAzucar() = 120

method esBonito() = cantidadColores > 3

  
}

class Cocinero{

var property especialidad  

method cocinar() = especialidad.cocinar(self)

method calificar(plato) = especialidad.catar(plato)

}

class Pastelero {
  var nivelDeseadoDeDulzor

  method catar(plato) = 5 * plato.cantidadDeAzucar() / nivelDeseadoDeDulzor

  method cocinar(cocinero) = new Postre(cocinero = cocinero, cantidadColores = nivelDeseadoDeDulzor / 50)
}

class Chef {
  
  var cantidadCaloriasDeseadas

  method cumpleExpectativa(plato) = plato.esBonito() && plato.calorias() <= cantidadCaloriasDeseadas

  method catar(plato) = if(self.cumpleExpectativa(plato)) 10 else self.calificacionSiNoCumpleExpectativa(plato)
	
	method calificacionSiNoCumpleExpectativa(plato) = 0

  method cocinar(cocinero) = new Principal(cocinero = cocinero, esBonito = true, cantidadDeAzucar = cantidadCaloriasDeseadas)

}

class Souschef inherits Chef {
  
	override method calificacionSiNoCumpleExpectativa(plato) = plato.cantidadCalorias() / 100

  override method cocinar(cocinero) = new Entrada(cocinero = cocinero)
}


class Torneo{

  const catadores = []
  const platos = []

  method ganador(){
    if(platos.isEmpty())
      throw new DomainException(message = "No se puede definir el ganador de un torneo sin participantes")
    return platos.max({plato => self.calificarPlato(plato)}).cocinero()
    
  }

  method calificarPlato(plato) = catadores.sum({catador => catador.catar(plato)})

  method agregarPlato(cocinero){
    platos.add(cocinero.cocinar())
  }
}